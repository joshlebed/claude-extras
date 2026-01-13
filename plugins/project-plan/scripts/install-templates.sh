#!/bin/bash
#
# Install project documentation templates into the current project
# This script copies templates from the plugin to .project-plan/_templates/
#
# Usage: install-templates.sh [--force]
#   --force: Overwrite existing templates without prompting

set -e

# Use CLAUDE_PLUGIN_ROOT if available, otherwise assume script is in scripts/
if [ -n "${CLAUDE_PLUGIN_ROOT}" ]; then
    PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PLUGIN_ROOT="$(dirname "${SCRIPT_DIR}")"
fi

# Get root directory for project files (original CWD, for multi-directory support)
ROOT_DIR="${PROJECT_PLAN_ROOT_DIR:-.}"

TEMPLATES_SRC="${PLUGIN_ROOT}/templates"
TEMPLATES_DST="$ROOT_DIR/.project-plan/_templates"

# Check if templates source exists
if [ ! -d "${TEMPLATES_SRC}" ]; then
    echo "Error: Templates not found at ${TEMPLATES_SRC}"
    exit 1
fi

# Check for --force flag
FORCE=false
if [ "$1" = "--force" ]; then
    FORCE=true
fi

# Check if already initialized
if [ -d "${TEMPLATES_DST}" ] && [ "${FORCE}" = false ]; then
    echo "Templates already exist at ${TEMPLATES_DST}"
    echo "Use --force to overwrite"
    exit 0
fi

# Create directory structure
mkdir -p "${TEMPLATES_DST}"

# Copy templates
cp -r "${TEMPLATES_SRC}"/* "${TEMPLATES_DST}/"

echo "Installed templates to ${TEMPLATES_DST}/"
echo ""
echo "Files created:"
ls -1 "${TEMPLATES_DST}/"

# Optionally update .gitignore in the root directory
GITIGNORE_FILE="$ROOT_DIR/.gitignore"
if command -v git &> /dev/null && git -C "$ROOT_DIR" rev-parse --git-dir &> /dev/null 2>&1; then
    if [ -f "$GITIGNORE_FILE" ]; then
        if ! grep -q "^\.project-plan/?$" "$GITIGNORE_FILE" 2>/dev/null; then
            echo "" >> "$GITIGNORE_FILE"
            echo ".project-plan/" >> "$GITIGNORE_FILE"
            echo ""
            echo "Added .project-plan/ to .gitignore"
        fi
    else
        echo ".project-plan/" > "$GITIGNORE_FILE"
        echo ""
        echo "Created .gitignore with .project-plan/"
    fi
fi

echo ""
echo "Next steps:"
echo "  1. Run /project-plan:new <project-name> to create project documentation"
echo "  2. Run /project-plan:work <project-slug> to work through tasks"
echo "  3. Run /project-plan:status to check progress"
