This folder contains tools for building and deploying the data specification website

## Data Specification Website Generation

### Overview

The data specification website is automatically generated from:
- **Condition descriptions**: Markdown files in `conditions/*/description.md`
- **HTML templates**: Template files in `templates/`
- **Build script**: `generate-site.sh` orchestrates the build process

### How It Works

#### Automatic Detection
The `generate-site.sh` script automatically discovers all conditions by:
- Scanning the `conditions/` directory
- Finding subdirectories that contain a `description.md` file
- No manual registration needed - new conditions are picked up automatically

#### Generation Process
1. **Scans conditions directory** for all subdirectories with `description.md`
2. **Converts markdown to HTML** using pandoc
3. **Generates individual condition pages** from the condition template
4. **Extracts preview text** from each condition's first paragraph
5. **Creates condition cards** with links and previews
6. **Builds the main index page** with all condition links

### Requirements

- `pandoc` - Document converter (required for markdown to HTML conversion)

Install on macOS:
```bash
brew install pandoc
```

Install on Ubuntu/Debian:
```bash
sudo apt-get install pandoc
```

### Usage

#### Local Build
```bash
./scripts/generate-site.sh
```

This generates the website in the `site/` directory with:
- `site/index.html` - Main landing page with condition links
- `site/{condition-name}.html` - Individual condition pages

#### Automatic GitHub Pages Deployment

The workflow is configured in `.github/workflows/publish-pages.yml` and:
1. Runs automatically on manual workflow dispatch
2. Installs dependencies (pandoc)
3. Runs the site generation script
4. Deploys to GitHub Pages branch (`gh-pages`)

Trigger manually from the GitHub Actions tab.

### Adding New Conditions

To add a new condition:
1. Create a new directory in `conditions/` with the condition name
2. Add a `description.md` file with the condition details
3. Run the build script - the new condition is automatically detected
4. Commit and push - GitHub Actions will deploy the updated site

Example structure:
```
conditions/
  my-new-condition/
    description.md
    code_lists/
      codes.csv
```

### Removing Conditions

Simply delete the condition directory - the build script automatically excludes deleted conditions from the generated site.

### File Structure

- `templates/index.html` - Main landing page template
- `templates/condition.html` - Individual condition page template
- `scripts/generate-site.sh` - Build script
- `site/` - Generated output directory (created at build time)

### Template Variables

#### index.html
- `<!-- CONDITION_CARDS_PLACEHOLDER -->` - Replaced with generated condition cards

#### condition.html
- `{{CONDITION_NAME}}` - Replaced with condition name
- `{{CONDITION_CONTENT}}` - Replaced with converted markdown HTML

### Styling

Both templates include inline CSS for consistent styling with a modern, professional appearance featuring:
- Purple gradient header
- Responsive card grid layout
- Hover effects
- Professional typography

### Troubleshooting

#### "pandoc is not installed"
Install pandoc using your package manager (see Requirements section above)

#### Missing conditions in generated site
Ensure each condition directory has a `description.md` file at the top level, not in subdirectories.

#### Empty preview text
The script extracts the first non-heading line from `description.md`. Ensure your description starts with introductory text.

---

## Code List Generation Scripts

Each code list generation script should have a top level description of what its inputs and outputs are, and the specific algorithms/logic it implements.