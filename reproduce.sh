#!/usr/bin/env bash
set -euo pipefail

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

python3 -m venv "$WORKDIR/venv"
"$WORKDIR/venv/bin/pip" install -q 'bandit==1.9.4'

printf 'assert True\n' > "$WORKDIR/demo.py"

echo "=== Environment ==="
python3 --version
"$WORKDIR/venv/bin/bandit" --version

echo
echo "=== CONTROL: -ii -ll ==="
set +e
"$WORKDIR/venv/bin/bandit" -ii -ll "$WORKDIR/demo.py"
echo "exit=$?"

echo
echo "=== REPRODUCTION A: -ii -ll -ii -ll ==="
"$WORKDIR/venv/bin/bandit" -ii -ll -ii -ll "$WORKDIR/demo.py"
echo "exit=$?"

echo
echo "=== REPRODUCTION B: -ll -ii -ll -ii ==="
"$WORKDIR/venv/bin/bandit" -ll -ii -ll -ii "$WORKDIR/demo.py"
echo "exit=$?"
