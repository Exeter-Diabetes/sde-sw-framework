#!/usr/bin/env python3

"""
Build Data Specification Website

This script generates HTML pages from markdown documentation for conditions.
It automatically detects all conditions in the conditions/ directory.
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

def generate_condition_pages(conditions_dir, templates_dir, output_dir, temp_dir):
    """Generate individual condition pages"""
    log_info("Generating condition pages...")
    
    condition_cards = []
    
    # Find all condition directories
    conditions = sorted([d for d in conditions_dir.iterdir() if d.is_dir()])
    
    for condition_dir in conditions:
        condition_name = condition_dir.name
        description_file = condition_dir / "description.md"
        
        if not description_file.exists():
            log_error(f"Missing description.md in {condition_dir}")
            continue
        
        log_info(f"Processing condition: {condition_name}")
        
        # Convert markdown to HTML
        temp_html = temp_dir / f"{condition_name}.html"
        markdown_to_html(str(description_file), str(temp_html))
        
        # Read the generated HTML
        with open(temp_html, 'r') as f:
            condition_content = f.read()
        
        # Check for code_lists directory
        code_lists_section = ""
        code_lists_dir = condition_dir / "code_lists"
        if code_lists_dir.exists():
            # Copy code_lists to site
            site_code_lists = output_dir / "code_lists" / condition_name
            site_code_lists.mkdir(parents=True, exist_ok=True)
            
            for csv_file in code_lists_dir.glob("*.csv"):
                shutil.copy(csv_file, site_code_lists / csv_file.name)
            
            # Generate code lists section with links
            code_lists_section = '<div class="code-lists">\n'
            code_lists_section += '<h2>Code Lists</h2>\n'
            code_lists_section += '<ul>\n'
            
            for csv_file in sorted(code_lists_dir.glob("*.csv")):
                filename = csv_file.name
                code_lists_section += f'<li><a href="code_lists/{condition_name}/{filename}">{filename}</a></li>\n'
            
            code_lists_section += '</ul>\n'
            code_lists_section += '</div>'
        
        # Create condition page from template
        with open(templates_dir / "condition.html", 'r') as f:
            condition_page = f.read()
        
        condition_page = condition_page.replace('{{CONDITION_NAME}}', condition_name)
        condition_page = condition_page.replace('{{CONDITION_CONTENT}}', condition_content)
        condition_page = condition_page.replace('{{CODE_LISTS_SECTION}}', code_lists_section)
        
        output_file = output_dir / f"{condition_name}.html"
        with open(output_file, 'w') as f:
            f.write(condition_page)
        
        log_success(f"Generated: {output_file}")
        
        # Get preview text for the card
        preview = get_preview_text(str(description_file))
        
        # Create card HTML
        card = f'<a href="{condition_name}.html" class="condition-card">\n'
        card += f'<h3>{condition_name}</h3>\n'
        card += f'<p>{preview}</p>\n'
        card += '<span class="arrow">View Details →</span>\n'
        card += '</a>\n'
        
        condition_cards.append(card)
    
    return '\n'.join(condition_cards)

def generate_index_page(templates_dir, output_dir, condition_cards):
    """Generate main index page"""
    log_info("Generating main index page...")
    
    with open(templates_dir / "index.html", 'r') as f:
        index_template = f.read()
    
    index_template = index_template.replace('<!-- CONDITION_CARDS_PLACEHOLDER -->', condition_cards)
    
    output_file = output_dir / "index.html"
    with open(output_file, 'w') as f:
        f.write(index_template)
    
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
    conditions_dir = project_root / "conditions"
    templates_dir = script_dir / "templates"
    output_dir = project_root / "site"
    
    # Create temporary directory
    with tempfile.TemporaryDirectory() as temp_dir:
        temp_dir = Path(temp_dir)
        
        try:
            check_dependencies()
            
            # Create output directory
            output_dir.mkdir(exist_ok=True)
            log_success(f"Output directory ready: {output_dir}")
            
            # Generate condition pages
            condition_cards = generate_condition_pages(
                conditions_dir, templates_dir, output_dir, temp_dir
            )
            
            if not condition_cards.strip():
                log_error("No conditions found with description.md files")
                sys.exit(1)
            
            # Generate index page
            generate_index_page(templates_dir, output_dir, condition_cards)
            
            print()
            log_success("Build complete!")
            print(f"Output directory: {output_dir}")
            
        except Exception as e:
            log_error(f"Build failed: {e}")
            sys.exit(1)

if __name__ == "__main__":
    main()
