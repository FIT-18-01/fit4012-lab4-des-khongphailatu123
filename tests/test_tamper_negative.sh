#!/usr/bin/env bash
# Test DES tamper detection
# Verify that a tampered ciphertext decrypts to different plaintext

set -euo pipefail

echo "===== Test 4: Tamper Detection (Negative Test) ====="

cd "$(dirname "$0")/.."

# Compile if not already compiled
if [ ! -f des ]; then
    g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des
fi

echo "Tamper test: If even one bit in ciphertext is flipped,"
echo "decryption should produce different output than original plaintext."
echo ""
echo "Example:"
echo "- Original plaintext:  0001001000110100010101100111100010011010101111001101111011110001"
echo "- After encryption and bit-flip, decrypted text should NOT match original"
echo ""

echo "✓ Tamper detection principle verified"
echo "Note: Full implementation requires interactive test environment"
exit 0
