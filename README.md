# md2pdf GitHub Repository Structure

## 1. README.md

```markdown
# md2pdf

A simple Bash script to convert all Markdown files in a directory to PDF using Pandoc and wkhtmltopdf.

![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)

## Features

- Automatically finds all Markdown files (`.md`) in the current directory
- Converts each file to PDF using Pandoc with wkhtmltopdf as the PDF engine
- Provides a detailed conversion summary
- Performs dependency checks before conversion

## Requirements

- [Pandoc](https://pandoc.org/installing.html)
- [wkhtmltopdf](https://wkhtmltopdf.org/downloads.html)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/md2pdf.git
   ```

2. Make the script executable:
   ```bash
   chmod +x md2pdf.sh
   ```

3. Optionally, move the script to a directory in your PATH for system-wide access:
   ```bash
   sudo cp md2pdf.sh /usr/local/bin/md2pdf
   ```

## Usage

Navigate to a directory containing Markdown files and run the script:

```bash
./md2pdf.sh
```

The script will:
1. Check if the required dependencies are installed
2. Find all `.md` files in the current directory
3. Convert each file to PDF with the same name (e.g., `document.md` → `document.pdf`)
4. Display a summary of the conversion process

## Example

```
$ ./md2pdf.sh
Converting 'document.md' to 'document.pdf'...
✓ Conversion completed successfully for document.md
-----------------------------------
Converting 'notes.md' to 'notes.pdf'...
✓ Conversion completed successfully for notes.md
-----------------------------------

Conversion Summary:
-----------------------------------
Total Markdown files processed: 2
Successful conversions: 2
Failed conversions: 0
-----------------------------------
All conversions completed successfully!
```

For more detailed usage instructions, see the [Usage Guide](docs/usage.md).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
See the [Contributing Guidelines](CONTRIBUTING.md) for more details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

## 2. LICENSE

```
MIT License

Copyright (c) 2025 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 3. md2pdf.sh (Your Script)

```bash
#!/bin/bash

# md_to_pdf.sh - A script to convert all Markdown files in the current directory to PDF using Pandoc
# Usage: ./md2pdf.sh

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
```

## 4. .gitignore

```
# Output PDFs
*.pdf

# macOS system files
.DS_Store

# Linux backup files
*~

# Windows thumbnail cache files
Thumbs.db
```

## 5. CONTRIBUTING.md

```markdown
# Contributing to md2pdf

Thank you for considering contributing to md2pdf! Here are some guidelines to help you get started.

## How Can I Contribute?

### Reporting Bugs

If you encounter any bugs or issues, please open an issue on GitHub with:
- A clear, descriptive title
- A detailed description of the issue
- Steps to reproduce the behavior
- Any relevant information about your environment (OS, Pandoc/wkhtmltopdf versions)

### Suggesting Enhancements

Have an idea to make md2pdf better? Open an issue with:
- A clear, descriptive title
- A detailed description of the enhancement
- Any examples or mockups if applicable

### Pull Requests

1. Fork the repository
2. Create a new branch for your feature (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## Style Guidelines

- Follow the existing code style
- Add comments for complex logic
- Test your changes before submitting

## License

By contributing to md2pdf, you agree that your contributions will be licensed under the project's MIT License.
```

## 6. CHANGELOG.md

```markdown
# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-03-27

### Added
- Initial release of the md2pdf script
- Support for converting all Markdown files in current directory to PDF
- Dependency checking for Pandoc and wkhtmltopdf
- Detailed conversion summary
```

## 7. docs/usage.md

```markdown
# Detailed Usage Guide

## Basic Usage

The basic usage of md2pdf is simple:

```bash
./md2pdf.sh
```

This will convert all Markdown files in the current directory to PDF.

## Advanced Usage

### Custom PDF Styling

To customize the appearance of your PDFs, you can modify the script to include additional Pandoc options.

For example, to include a custom CSS file:

```bash
pandoc "$INPUT_FILE" -t html -o "$OUTPUT_FILE" --pdf-engine=wkhtmltopdf --css=style.css
```

Create a file named `style.css` in the same directory with your custom styles.

### Converting Specific Files

If you want to convert only specific Markdown files instead of all files in the directory, you can modify the script to accept file arguments:

```bash
if [ $# -eq 0 ]; then
    # No arguments provided, use all MD files
    MD_FILES=$(find . -maxdepth 1 -type f -name "*.md")
else
    # Use provided file arguments
    MD_FILES="$@"
fi
```

Then you can use:

```bash
./md2pdf.sh file1.md file2.md
```

### Recursive Directory Processing

To process Markdown files in subdirectories as well, modify the find command:

```bash
MD_FILES=$(find . -type f -name "*.md")
```

## Troubleshooting

### PDF Generation Fails

If PDF generation fails, check:

1. Make sure Pandoc and wkhtmltopdf are properly installed
2. Check if your Markdown file contains valid syntax
3. If you're using custom CSS, ensure it's valid

### Font or Rendering Issues

If the PDF looks incorrect:

1. wkhtmltopdf might not have access to certain fonts
2. Try using a different PDF engine like pdflatex if installed:

```bash
pandoc "$INPUT_FILE" -o "$OUTPUT_FILE" --pdf-engine=pdflatex
```

## Integration Ideas

### Adding to Your PATH

For system-wide access, add the script to your PATH:

```bash
cp md2pdf.sh /usr/local/bin/md2pdf
chmod +x /usr/local/bin/md2pdf
```

### Git Hooks

You can use md2pdf as a pre-commit or post-commit hook to automatically generate PDFs when Markdown files change.
```
