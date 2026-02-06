#!/usr/bin/env bash
# FHIRLab Core Documentation - Local Development Server
# =====================================================
# Starts a local MkDocs development server for previewing documentation.
#
# Usage:
#   ./serve.sh
#
# The documentation will be available at http://localhost:8000

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[Docs]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[Docs]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[Docs]${NC} $1"
}

print_error() {
    echo -e "${RED}[Docs]${NC} $1"
}

# Check for Python
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is required but not installed."
    echo "Install Python 3 and try again."
    exit 1
fi

# Check for pip
if ! command -v pip3 &> /dev/null && ! command -v pip &> /dev/null; then
    print_error "pip is required but not installed."
    exit 1
fi

PIP_CMD="pip3"
if ! command -v pip3 &> /dev/null; then
    PIP_CMD="pip"
fi

# Check if mkdocs is installed
if ! command -v mkdocs &> /dev/null; then
    print_warning "MkDocs not found. Installing dependencies..."
    $PIP_CMD install -r requirements.txt
fi

# Check if mkdocs-material is installed
if ! python3 -c "import material" 2>/dev/null; then
    print_warning "MkDocs Material theme not found. Installing dependencies..."
    $PIP_CMD install -r requirements.txt
fi

print_success "Starting documentation server..."
echo ""
echo "Documentation will be available at:"
echo -e "  ${GREEN}http://localhost:8000${NC}"
echo ""
echo "Press Ctrl+C to stop the server."
echo ""

# Start MkDocs development server
mkdocs serve
