#!/bin/bash
# Helper script to get the Claude projects path for current directory
# Usage: source get-project-path.sh

# Convert current directory to Claude's project path format
# /Users/victor/workspace/project -> -Users-victor-workspace-project
get_project_path() {
    local pwd_path="${1:-$PWD}"
    local project_dir=$(echo "$pwd_path" | sed 's|^/||' | sed 's|/|-|g')
    echo "$HOME/.claude/projects/$project_dir"
}

# Check if project path exists
check_project_exists() {
    local project_path=$(get_project_path "$1")
    if [[ -d "$project_path" ]]; then
        echo "$project_path"
        return 0
    else
        echo "No sessions found for this project" >&2
        return 1
    fi
}

# List sessions in current project
list_project_sessions() {
    local project_path=$(get_project_path "$1")
    if [[ -d "$project_path" ]]; then
        find "$project_path" -name "*.jsonl" -type f | sort -r | head -20
    else
        echo "No sessions found" >&2
        return 1
    fi
}

# If script is run directly (not sourced), show usage
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "Project path: $(get_project_path)"
    echo ""
    echo "Sessions:"
    list_project_sessions
fi
