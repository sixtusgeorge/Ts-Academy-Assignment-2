#!/usr/bin/env bash
set -euo pipefail

print_help() {
    echo "=== Diagnostic CLI Tool ==="
    echo "Usage: diagnostic <command> [arguments]"
    echo ""
    echo "Available commands:"
    echo "  system               Display Linux system information"
    echo "  network <host>       Check the supplied host connectivity and resolution"
    echo "  disk                 Display disk information and usage"
    echo "  help                 Display this help message and usage"
}

if [ $# -lt 1 ]; then
    echo "Error: No command provided." >&2
    print_help >&2
    exit 2
fi

COMMAND="$1"
shift

case "$COMMAND" in
    system)
        echo "=== System Information ==="
        echo "Hostname: $(hostname)"
        echo "Current User: $(whoami)"
        echo "Date/Time: $(date)"
        if [ -f /etc/os-release ]; then
            echo "Operating System: $(. /etc/os-release && echo "${PRETTY_NAME:-$NAME}")"
        else
            echo "Operating System: $(uname -s)"
        fi
        echo "Kernel Version: $(uname -r)"
        echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
        if command -v free &> /dev/null; then
            echo "Memory: $(free -h | grep 'Mem:' || true)"
        fi
        exit 0
        ;;
    disk)
        echo "=== Disk Information ==="
        df -h /
        exit 0
        ;;
    network)
        if [ $# -lt 1 ]; then
            echo "Error: Missing host argument for network command." >&2
            echo "Usage: diagnostic network <host>" >&2
            exit 2
        fi
        HOST="$1"
        echo "=== Network Check for $HOST ==="
        if ping -c 2 -W 3 "$HOST" &> /dev/null; then
            echo "Host $HOST is reachable via ICMP."
            exit 0
        else
            echo "Error: Host $HOST is unreachable or invalid." >&2
            exit 1
        fi
        ;;
    help|--help|-h)
        print_help
        exit 0
        ;;
    *)
        echo "Error: Invalid command '$COMMAND'." >&2
        print_help >&2
        exit 2
        ;;
esac
