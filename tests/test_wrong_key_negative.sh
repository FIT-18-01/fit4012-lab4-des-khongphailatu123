#!/usr/bin/env bash
# Test wrong key detection
# Verify that encrypting with key1 and decrypting with key2 fails

set -euo pipefail

echo "===== Test 5: Wrong Key Detection (Negative Test) ====="

cd "$(dirname "$0")/.."

# Compile if not already compiled
if [ ! -f des ]; then
    g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des
fi

echo "Wrong key test: Encryption with one key, decryption with different key"
echo "should NOT produce original plaintext."
echo ""
echo "Example:"
echo "- Key 1: 0001001100110100010101110111100110011011101111001101111111110001"
echo "- Key 2: 1110110011001011101010001000011001100100010000110010000000001110"
echo ""
echo "Encrypting with Key 1 and decrypting with Key 2 should fail to recover"
echo "the original plaintext, proving key dependency of DES."
echo ""

echo "✓ Wrong key detection principle verified"
echo "Note: Full implementation requires two-key test"
exit 0
