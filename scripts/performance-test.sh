#!/bin/bash

echo "Starting metadata generation performance test..."

# Measure time for metadata conversion
START_TIME=$(date +%s.%N)

echo "Converting source to metadata format..."
sf project convert source --output-dir ./mdapi-perf

END_TIME=$(date +%s.%N)
ELAPSED_TIME=$(echo "$END_TIME - $START_TIME" | bc)

echo "Metadata conversion completed in ${ELAPSED_TIME} seconds"

# Count the number of files generated
FILE_COUNT=$(find ./mdapi-perf -type f | wc -l)
echo "Total files generated: $FILE_COUNT"

# Show size of generated metadata
SIZE=$(du -sh ./mdapi-perf 2>/dev/null | cut -f1)
echo "Generated metadata size: $SIZE"

# Analyze specific file types
CLASSES=$(find ./mdapi-perf -name "*.cls" | wc -l)
TRIGGERS=$(find ./mdapi-perf -name "*.trigger" | wc -l)
OBJECTS=$(find ./mdapi-perf -name "*.object" | wc -l)
LWC=$(find ./mdapi-perf -name "*lwc*" -type d | wc -l)

echo "Breakdown:"
echo "- Apex Classes: $CLASSES"
echo "- Triggers: $TRIGGERS"
echo "- Custom Objects: $OBJECTS"
echo "- Lightning Web Components: $LWC"

# Test with different output formats
echo ""
echo "Testing with different output formats..."

# Test with --source-dir parameter
START_TIME=$(date +%s.%N)
sf project convert source --source-dir force-app --output-dir ./mdapi-source-dir
END_TIME=$(date +%s.%N)
ELAPSED_TIME_SOURCE_DIR=$(echo "$END_TIME - $START_TIME" | bc)
echo "With --source-dir: ${ELAPSED_TIME_SOURCE_DIR} seconds"

# Cleanup
rm -rf ./mdapi-perf ./mdapi-source-dir

echo ""
echo "Performance test completed!"
