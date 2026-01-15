#!/usr/bin/env python3

"""
Build Data Specification Website

This script generates HTML pages from markdown documentation for datasets.
It automatically detects all datasets organized by category in the code_lists/ directory.
"""

import sys
import subprocess
import shutil
import tempfile
from pathlib import Path

# Color codes for output
RED = '\033[0;31m'
GREEN = '\033[0;32m'
BLUE = '\033[0;34m'
NC = '\033[0m'  # No Color

def log_info(msg):
    """Log info message to stderr"""
    print(f"{BLUE}ℹ{NC} {msg}", file=sys.stderr)

def log_success(msg):
    """Log success message to stderr"""
    print(f"{GREEN}✓{NC} {msg}", file=sys.stderr)

def log_error(msg):
    """Log error message to stderr"""
    print(f"{RED}✗{NC} {msg}", file=sys.stderr)

def check_dependencies():
    """Check if pandoc is installed"""
    if shutil.which('pandoc') is None:
        log_error("pandoc is not installed. Please install pandoc to continue.")
        sys.exit(1)
    log_success("pandoc found")

def markdown_to_html(md_file, temp_html):
    """Convert markdown to HTML using pandoc"""
    try:
        subprocess.run(
            ['pandoc', md_file, '-t', 'html', '--mathjax'],
            stdout=open(temp_html, 'w'),
            check=True
        )
    except subprocess.CalledProcessError as e:
        log_error(f"Failed to convert {md_file}: {e}")
        raise

def get_preview_text(md_file, max_chars=150):
    """Extract first paragraph from markdown for preview"""
    try:
        with open(md_file, 'r') as f:
            for line in f:
                line = line.strip()
                # Skip headers and empty lines
                if not line or line.startswith('#'):
                    continue
                return line[:max_chars]
    except Exception:
        return ""
    return ""

def generate_dataset_pages(category_dir, category_name, templates_dir, output_dir, temp_dir):
    """Generate individual dataset pages for a category"""
    log_info(f"Generating dataset pages for category: {category_name}")
    
    dataset_cards = []
    
    # Find all dataset directories (subdirectories with info.md)
    datasets = sorted([d for d in category_dir.iterdir() if d.is_dir()])
    
    for dataset_dir in datasets:
        dataset_name = dataset_dir.name
        info_file = dataset_dir / "info.md"
        
        if not info_file.exists():
            log_error(f"Missing info.md in {dataset_dir}")
            continue
        
        log_info(f"Processing dataset: {dataset_name} ({category_name})")
        
        # Convert markdown to HTML
        temp_html = temp_dir / f"{category_name}_{dataset_name}.html"
        markdown_to_html(str(info_file), str(temp_html))
        
        # Read the generated HTML
        with open(temp_html, 'r') as f:
            dataset_content = f.read()
        
        # Check for CSV files
        code_lists_section = ""
        csv_files = list(dataset_dir.glob("*.csv"))
        if csv_files:
            # Copy CSV files to site
            site_code_lists = output_dir / "code_lists" / category_name / dataset_name
            site_code_lists.mkdir(parents=True, exist_ok=True)
            
            for csv_file in csv_files:
                shutil.copy(csv_file, site_code_lists / csv_file.name)
            
            # Generate code lists section with links
            code_lists_section = '<div class="code-lists">\n'
            code_lists_section += '<h2>Code Lists</h2>\n'
            code_lists_section += '<ul>\n'
            
            for csv_file in sorted(csv_files):
                filename = csv_file.name
                code_lists_section += f'<li><a href="../code_lists/{category_name}/{dataset_name}/{filename}">{filename}</a></li>\n'
            
            code_lists_section += '</ul>\n'
            code_lists_section += '</div>'
        
        # Create dataset page from template
        with open(templates_dir / "dataset.html", 'r') as f:
            dataset_page = f.read()
        
        dataset_page = dataset_page.replace('{{DATASET_NAME}}', dataset_name)
        dataset_page = dataset_page.replace('{{DATASET_CONTENT}}', dataset_content)
        dataset_page = dataset_page.replace('{{CODE_LISTS_SECTION}}', code_lists_section)
        
        # Create category subdirectory in site
        category_output_dir = output_dir / category_name
        category_output_dir.mkdir(parents=True, exist_ok=True)
        
        output_file = category_output_dir / f"{dataset_name}.html"
        with open(output_file, 'w') as f:
            f.write(dataset_page)
        
        log_success(f"Generated: {output_file}")
        
        # Get preview text for the card
        preview = get_preview_text(str(info_file))
        
        # Create card HTML
        card = f'<a href="{category_name}/{dataset_name}.html" class="dataset-card">\n'
        card += f'<h3>{dataset_name}</h3>\n'
        card += f'<p>{preview}</p>\n'
        card += '<span class="arrow">View Details →</span>\n'
        card += '</a>\n'
        
        dataset_cards.append(card)
    
    return '\n'.join(dataset_cards)

def generate_index_page(templates_dir, output_dir, categories_data):
    """Generate main index page with all categories"""
    log_info("Generating main index page...")
    
    with open(templates_dir / "index.html", 'r') as f:
        index_template = f.read()
    
    # Build category sections
    category_sections = []
    for category_name, dataset_cards in categories_data:
        capitalized_name = category_name[0].upper() + category_name[1:] if category_name else category_name
        category_section = f'        <h2 class="section-title">{capitalized_name}</h2>\n'
        category_section += '        <div class="datasets">\n'
        category_section += dataset_cards
        category_section += '        </div>\n\n'
        category_sections.append(category_section)
    
    # Replace placeholder with all category sections
    categories_html = ''.join(category_sections)
    final_html = index_template.replace('<!-- CATEGORIES_PLACEHOLDER -->', categories_html)
    
    output_file = output_dir / "index.html"
    with open(output_file, 'w') as f:
        f.write(final_html)
    
    log_success(f"Generated: {output_file}")

def main():
    """Main execution"""
    print("=" * 44)
    print("Data Specification Website Generator")
    print("=" * 44)
    print()
    
    # Set up paths
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    code_lists_dir = project_root / "code_lists"
    templates_dir = script_dir / "templates"
    output_dir = project_root / "site"
    
    # Check if code_lists directory exists
    if not code_lists_dir.exists():
        log_error(f"code_lists directory not found at {code_lists_dir}")
        sys.exit(1)
    
    # Create temporary directory
    with tempfile.TemporaryDirectory() as temp_dir:
        temp_dir = Path(temp_dir)
        
        try:
            check_dependencies()
            
            # Create output directory
            output_dir.mkdir(exist_ok=True)
            log_success(f"Output directory ready: {output_dir}")
            
            # Find all categories
            categories = sorted([d for d in code_lists_dir.iterdir() if d.is_dir()])
            
            if not categories:
                log_error("No categories found in code_lists directory")
                sys.exit(1)
            
            # Generate dataset pages for each category
            categories_data = []
            for category_dir in categories:
                category_name = category_dir.name
                dataset_cards = generate_dataset_pages(
                    category_dir, category_name, templates_dir, output_dir, temp_dir
                )
                
                if dataset_cards.strip():
                    categories_data.append((category_name, dataset_cards))
            
            if not categories_data:
                log_error("No datasets found with info.md files")
                sys.exit(1)
            
            # Generate index page
            generate_index_page(templates_dir, output_dir, categories_data)
            
            print()
            log_success("Build complete!")
            print(f"Output directory: {output_dir}")
            
        except Exception as e:
            log_error(f"Build failed: {e}")
            import traceback
            traceback.print_exc()
            sys.exit(1)

if __name__ == "__main__":
    main()
