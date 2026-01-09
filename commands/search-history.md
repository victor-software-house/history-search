---
name: search-history
description: Search through previous Claude Code sessions in the current project using semantic search
allowed-tools:
  - Bash
argument-hint: "<query>"
---

# Search Session History

Search through past Claude Code sessions to find relevant discussions, code, and solutions.

## Instructions

When the user invokes `/search-history "query"`:

1. **Determine current project path** for scoping:
   ```bash
   # Source helper functions
   source "${CLAUDE_PLUGIN_ROOT}/scripts/get-project-path.sh"
   SEARCH_PATH=$(get_project_sessions_path)
   ```

2. **Execute semantic search** using the CLI tool:
   ```bash
   claude-search "USER_QUERY" 2>/dev/null | head -50
   ```

3. **Parse and format results**:
   - Extract top 5-10 matches
   - Show ~500 character snippets for each match
   - Group by session with timestamps
   - Include session ID for reference

4. **Present results** in a clear format:
   ```
   ## Search Results for "query"

   ### Session abc123... (2024-01-05)
   **Human**: [snippet...]
   **Assistant**: [snippet...]

   ### Session def456... (2024-01-03)
   ...
   ```

5. **If no results found**, suggest:
   - Trying broader search terms
   - Using `/list-sessions` to browse manually
   - Searching globally with `--global` flag (if implemented)

## Token Efficiency

- Return only relevant snippets (~500 chars each)
- Limit to top 10 results maximum
- Do NOT dump full conversations
- Use semantic matching to prioritize relevance

## Usage Examples

```
/search-history "authentication implementation"
/search-history "how to fix typescript errors"
/search-history "database migration approach"
```

## Error Handling

If `claude-search` is not installed:
```
The claude-conversation-extractor tool is not installed.
Install it with: pipx install claude-conversation-extractor
```
