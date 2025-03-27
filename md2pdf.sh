#!/bin/bash

# md_to_pdf.sh - A script to convert all Markdown files in the current directory to PDF using Pandoc
# Usage: ./md_to_pdf.sh

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed. Please install it first."
    echo "Visit https://pandoc.org/installing.html for installation instructions."
    exit 1
fi

# Check if wkhtmltopdf is installed
if ! command -v wkhtmltopdf &> /dev/null; then
    echo "Error: wkhtmltopdf is not installed. Please install it first."
    echo "Visit https://wkhtmltopdf.org/downloads.html for installation instructions."
    exit 1
fi

# Find all markdown files in the current directory
MD_FILES=$(find . -maxdepth 1 -type f -name "*.md")

# Check if any markdown files were found
if [ -z "$MD_FILES" ]; then
    echo "No Markdown files (*.md) found in the current directory."
    exit 1
fi

# Initialize counters
SUCCESS_COUNT=0
FAILURE_COUNT=0

# Process each markdown file
for INPUT_FILE in $MD_FILES; do
    # Strip the leading ./ if present
    INPUT_FILE=${INPUT_FILE#./}
    
    # Create output filename by replacing .md with .pdf
    OUTPUT_FILE="${INPUT_FILE%.md}.pdf"
    
    echo "Converting '$INPUT_FILE' to '$OUTPUT_FILE'..."
    
    # Run the conversion using pandoc
    pandoc "$INPUT_FILE" -t html -o "$OUTPUT_FILE" --pdf-engine=wkhtmltopdf
    
    # Check if the conversion was successful
    if [ $? -eq 0 ]; then
        echo "✓ Conversion completed successfully for $INPUT_FILE"
        ((SUCCESS_COUNT++))
    else
        echo "✗ Error: Conversion failed for $INPUT_FILE"
        ((FAILURE_COUNT++))
    fi
    
    echo "-----------------------------------"
done

# Print summary
echo ""
echo "Conversion Summary:"
echo "-----------------------------------"
echo "Total Markdown files processed: $((SUCCESS_COUNT + FAILURE_COUNT))"
echo "Successful conversions: $SUCCESS_COUNT"
echo "Failed conversions: $FAILURE_COUNT"
echo "-----------------------------------"

if [ $FAILURE_COUNT -eq 0 ]; then
    echo "All conversions completed successfully!"
else
    echo "Some conversions failed. Please check the logs above."
    exit 1
fi
