#!/bin/bash

# Build Data Specification Website
# This script generates HTML pages from markdown documentation for conditions
# It automatically detects all conditions in the conditions/ directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONDITIONS_DIR="$PROJECT_ROOT/conditions"
TEMPLATES_DIR="$PROJECT_ROOT/html/templates"
OUTPUT_DIR="$PROJECT_ROOT/site"
TEMP_DIR=$(mktemp -d)

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to log messages
log_info() {
    echo -e "${BLUE}ℹ${NC} $1" >&2
}

log_success() {
    echo -e "${GREEN}✓${NC} $1" >&2
}

log_error() {
    echo -e "${RED}✗${NC} $1" >&2
}

# Check dependencies
check_dependencies() {
    if ! command -v pandoc &> /dev/null; then
        log_error "pandoc is not installed. Please install pandoc to continue."
        exit 1
    fi
    log_success "pandoc found"
}

# Clean up temporary directory on exit
cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Create output directory
create_output_directory() {
    mkdir -p "$OUTPUT_DIR"
    log_success "Output directory ready: $OUTPUT_DIR"
}

# Convert markdown to HTML using pandoc with inline CSS
markdown_to_html() {
    local md_file="$1"
    local temp_html="$2"
    
    pandoc "$md_file" -t html --mathjax > "$temp_html"
}

# Extract first paragraph from markdown for preview
get_preview_text() {
    local md_file="$1"
    # Get first non-empty line after headers, up to 150 chars
    grep -v "^#" "$md_file" | grep -v "^$" | head -1 | cut -c 1-150
}

# Generate individual condition pages
generate_condition_pages() {
    log_info "Generating condition pages..."
    
    local condition_cards=""
    
    # Find all condition directories (directories containing description.md)
    while IFS= read -r -d '' condition_dir; do
        local condition_name=$(basename "$condition_dir")
        local description_file="$condition_dir/description.md"
        
        if [ ! -f "$description_file" ]; then
            log_error "Missing description.md in $condition_dir"
            continue
        fi
        
        log_info "Processing condition: $condition_name"
        
        # Convert markdown to HTML
        local temp_html="$TEMP_DIR/${condition_name}.html"
        markdown_to_html "$description_file" "$temp_html"
        
        # Read the generated HTML
        local condition_content=$(cat "$temp_html")
        
        # Create condition page from template
        local output_file="$OUTPUT_DIR/${condition_name}.html"
        local condition_page=$(cat "$TEMPLATES_DIR/condition.html")
        condition_page="${condition_page//\{\{CONDITION_NAME\}\}/$condition_name}"
        condition_page="${condition_page//\{\{CONDITION_CONTENT\}\}/$condition_content}"
        
        echo "$condition_page" > "$output_file"
        log_success "Generated: $output_file"
        
        # Get preview text for the card
        local preview=$(get_preview_text "$description_file")
        
        # Create card HTML
        local card="<a href=\"${condition_name}.html\" class=\"condition-card\">"
        card+="<h3>$condition_name</h3>"
        card+="<p>$preview</p>"
        card+="<span class=\"arrow\">View Details →</span>"
        card+="</a>"
        
        condition_cards+="$card"$'\n'
        
    done < <(find "$CONDITIONS_DIR" -maxdepth 1 -type d -not -path "$CONDITIONS_DIR" -print0 | sort -z)
    
    echo "$condition_cards"
}

# Generate main index page
generate_index_page() {
    log_info "Generating main index page..."
    
    local index_template=$(cat "$TEMPLATES_DIR/index.html")
    
    # Generate condition cards
    local condition_cards="$1"
    
    # Replace placeholder with generated cards
    index_template="${index_template//<!-- CONDITION_CARDS_PLACEHOLDER -->/$condition_cards}"
    
    local output_file="$OUTPUT_DIR/index.html"
    echo "$index_template" > "$output_file"
    log_success "Generated: $output_file"
}

# Main execution
main() {
    echo "============================================"
    echo "Data Specification Website Generator"
    echo "============================================"
    echo ""
    
    check_dependencies
    create_output_directory
    
    local condition_cards=$(generate_condition_pages)
    
    if [ -z "$condition_cards" ]; then
        log_error "No conditions found with description.md files"
        exit 1
    fi
    
    generate_index_page "$condition_cards"
    
    echo ""
    log_success "Build complete!"
    echo "Output directory: $OUTPUT_DIR"
}

main
