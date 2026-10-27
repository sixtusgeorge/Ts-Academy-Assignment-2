#!/usr/bin/env bash
set -euo pipefail

echo "=== Running Assignment 2 Grader ==="

# Check required files
REQUIRED_FILES=(
    "README.md"
    "Dockerfile"
    "compose.yaml"
    ".dockerignore"
    "test.sh"
    "grade.sh"
    "app/diagnostic.sh"
    "app/health-check.sh"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "FAIL: Required file missing: $file" >&2
        exit 1
    fi
    echo "PASS: Found $file"
done

# Check script permissions and syntax
SCRIPTS=("app/diagnostic.sh" "app/health-check.sh" "test.sh" "grade.sh")
for script in "${SCRIPTS[@]}"; do
    if [ ! -x "$script" ]; then
        echo "FAIL: Script is not executable: $script" >&2
        exit 1
    fi
    echo "PASS: $script is executable"
    bash -n "$script"
    echo "PASS: $script syntax check passed"
done

# Run student tests
echo "Running student test suite..."
./test.sh

# Test Docker build if docker is available
if command -v docker &> /dev/null; then
    echo "Building Docker image..."
    docker build -t diagnostic-tool .
    
    echo "Testing Docker container commands..."
    docker run --rm diagnostic-tool system > /dev/null
    docker run --rm diagnostic-tool disk > /dev/null
    docker run --rm diagnostic-tool help > /dev/null
    echo "PASS: Docker container commands executed successfully"
else
    echo "WARNING: Docker daemon not running or installed; skipping container build tests."
fi

echo "=== ALL ASSIGNMENT 2 GRADER CHECKS PASSED ==="
