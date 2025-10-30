#!/bin/bash

echo "Starting rollback and version control test..."

# Get current git commit hash
CURRENT_COMMIT=$(git rev-parse HEAD)
echo "Current commit: $CURRENT_COMMIT"

# Create a test file to simulate changes
echo "Test content for rollback" > test-rollback.txt

# Add and commit the test file
git add test-rollback.txt
git commit -m "Add test file for rollback testing"

# Get the new commit hash
NEW_COMMIT=$(git rev-parse HEAD)
echo "New commit after adding test file: $NEW_COMMIT"

# Show git log
echo "Git log:"
git log --oneline -n 5

# Test rollback to previous commit
echo "Rolling back to previous commit..."
git reset --hard $CURRENT_COMMIT

# Verify rollback
echo "Verifying rollback..."
VERIFY_COMMIT=$(git rev-parse HEAD)
echo "Commit after rollback: $VERIFY_COMMIT"

if [ "$VERIFY_COMMIT" = "$CURRENT_COMMIT" ]; then
    echo "✓ Rollback successful!"
else
    echo "✗ Rollback failed!"
    exit 1
fi

# Clean up test file
rm -f test-rollback.txt

echo "Rollback test completed successfully!"
