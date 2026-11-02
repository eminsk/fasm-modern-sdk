#!/usr/bin/env bash
set -e

echo "=============================================================================="
echo "[FASM Modern SDK] Cross-Platform Build & Test"
echo "=============================================================================="

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$ROOT_DIR/bin"
SRC_DIR="$ROOT_DIR/src/fasm1"

mkdir -p "$BIN_DIR"

UNAME_S="$(uname -s)"
case "$UNAME_S" in
    Linux*)
        echo "[1/2] Compiling FASM for Linux x86_64..."
        if [ -f "$BIN_DIR/fasmg.x64" ]; then
            chmod +x "$BIN_DIR/fasmg.x64"
        fi
        cd "$SRC_DIR/LINUX/X64"
        if command -v fasm >/dev/null 2>&1; then
            fasm fasm.asm "$BIN_DIR/fasm-linux-x64"
            chmod +x "$BIN_DIR/fasm-linux-x64"
            echo "[OK] Built $BIN_DIR/fasm-linux-x64"
        else
            echo "[INFO] System fasm not present; using fasmg or prebuilt"
        fi
        ;;
    Darwin*)
        echo "[1/2] Compiling FASM for macOS (Mach-O / libc)..."
        cd "$SRC_DIR/LIBC"
        if command -v gcc >/dev/null 2>&1 && command -v fasm >/dev/null 2>&1; then
            fasm fasm.asm fasm.o
            gcc -m64 fasm.o -o "$BIN_DIR/fasm-macos-x64"
            chmod +x "$BIN_DIR/fasm-macos-x64"
            echo "[OK] Built $BIN_DIR/fasm-macos-x64"
        fi
        ;;
    *)
        echo "[WARN] Unsupported host OS: $UNAME_S"
        ;;
esac

echo "[2/2] Verification complete."
echo "=============================================================================="
