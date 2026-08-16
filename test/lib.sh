# lib.sh — shared preamble for the pping2 test scripts. Sourced, never run.
# Exits non-zero straight away if pping2 has not been built.
#
# Provides: TEST_DIR PCAPS_DIR GOLDEN_DIR PPING, pass(), fail(), summary().
# $0 inside a sourced file is the sourcing script, so TEST_DIR resolves to
# test/ regardless of the caller's working directory.

TEST_DIR=$(cd "$(dirname "$0")" && pwd)
PPING="$TEST_DIR/../pping2"
PCAPS_DIR="$TEST_DIR/pcaps"
GOLDEN_DIR="$TEST_DIR/golden"

if [ ! -x "$PPING" ]; then
    echo "ERROR: $PPING not built; run 'make' first"
    exit 1
fi

PASS=0
FAIL=0
pass() { printf 'PASS %s\n' "$1"; PASS=$((PASS + 1)); }
fail() { printf 'FAIL %s: %s\n' "$1" "$2"; FAIL=$((FAIL + 1)); }

# summary <name> — print the tally and exit 1 if anything failed.
summary() {
    echo ""
    echo "$1: $PASS/$((PASS + FAIL)) checks passed"
    [ "$FAIL" -gt 0 ] && exit 1
    exit 0
}
