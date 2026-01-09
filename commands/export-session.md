---
name: export-session
description: Export a Claude Code session to Markdown with semantic filtering for relevant content
allowed-tools:
  - Bash
  - Write
  - Read
  - AskUserQuestion
argument-hint: "<session-id|latest|N>"
---

# Export Session

Export a Claude Code session to Markdown, with options for processing and filtering.

## Instructions

When the user invokes `/export-session`:

1. **Determine which session** to export:
   - If argument is `latest`: export most recent session
   - If argument is a number (1-10): export Nth session from list
   - If argument is session ID: export that specific session
   - If no argument: show list and ask user to select

2. **Ask user about export options** using AskUserQuestion:

   **Question 1: Export destination**
   - "Current directory" - save as `session-YYYY-MM-DD-HHMMSS.md`
   - "Specify path" - ask for custom path
   - "Temporary file" - save to `/tmp/` for one-time viewing

   **Question 2: Content filtering**
   - "Full export" - entire conversation
   - "Semantic filter" - ask for topic to focus on
   - "Code only" - extract only code blocks
   - "Summaries" - generate summary of key points

3. **Execute export** based on selections:
   ```bash
   # Full export
   claude-extract --session SESSION_ID --output OUTPUT_PATH

   # With semantic filtering (search within exported content)
   claude-search "FILTER_TOPIC" --session SESSION_ID
   ```

4. **For large exports**, use chunked reading:
   - Write to file first
   - Read in 2000-line chunks
   - Use semantic search to find most relevant portions
   - Present relevant chunks to user

5. **Post-processing options**:
   - Remove terminal artifacts and ANSI codes
   - Format code blocks properly
   - Add table of contents for long exports
   - Highlight key decisions or code changes

## Token Efficiency

- NEVER dump full conversation into context
- Always use semantic filtering when possible
- For large sessions, summarize sections
- Read files in chunks, present only relevant parts

## Usage Examples

```
/export-session latest
/export-session 3
/export-session abc123def456
```

## Output Formats

The exported Markdown includes:
```markdown
# Session Export: abc123...
**Date**: 2024-01-08
**Project**: /path/to/project

## Conversation

### Human (10:30 AM)
[content...]

### Assistant (10:31 AM)
[content...]

---
*Exported by history-search plugin*
```

## Error Handling

If session not found:
```
Session not found. Use /list-sessions to see available sessions.
```

If export fails:
```
Export failed: [error message]
Try exporting to /tmp/ if there are permission issues.
```
