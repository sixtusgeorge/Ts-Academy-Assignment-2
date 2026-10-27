#!/usr/bin/env bash
set -euo pipefail

echo "=== Running Student Test Suite (Assignment 2) ==="

# Test help command
echo "Testing help command..."
./app/diagnostic.sh help > /dev/null
echo "PASS: help command"

# Test system command
echo "Testing system command..."
./app/diagnostic.sh system > /dev/null
echo "PASS: system command"

# Test disk command
echo "Testing disk command..."
./app/diagnostic.sh disk > /dev/null
echo "PASS: disk command"

# Test invalid command handling (should exit 2)
echo "Testing invalid command handling..."
if ./app/diagnostic.sh invalidcmd 2>/dev/null; then
    echo "FAIL: Invalid command should return non-zero exit code" >&2
    exit 1
else
    echo "PASS: Invalid command correctly rejected"
fi

echo "=== ALL STUDENT TESTS PASSED SUCCESSFULLY ==="
