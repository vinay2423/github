#!/bin/bash

# Check for PDF files in the current directory
shopt -s nullglob
pdf_files=(*.pdf)

if [ ${#pdf_files[@]} -eq 0 ]; then
    echo "No PDF files found in the current directory."
    exit 1
fi

# Create a temporary directory for images
mkdir -p images

# Convert each PDF to PNG images
for pdf in "${pdf_files[@]}"; do
    pdftoppm "$pdf" "images/${pdf%.pdf}" -png
done

# Convert images to a single Word document
pandoc images/*.png -o output.docx

# Clean up temporary images
rm -r images

echo "Converted ${#pdf_files[@]} PDF files to output.docx"

