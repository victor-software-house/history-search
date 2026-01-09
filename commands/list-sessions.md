---
name: list-sessions
description: List recent Claude Code sessions in the current project with option to export
allowed-tools:
  - Bash
  - AskUserQuestion
argument-hint: "[--count N]"
---

# List Sessions

Browse recent Claude Code sessions and optionally export them.

## Instructions

When the user invokes `/list-sessions`:

1. **Get session list** for current project:
   ```bash
   claude-extract --list 2>/dev/null | head -20
   ```

2. **Parse and display** as a numbered table:
   ```
   ## Recent Sessions (Current Project)

   | # | Date       | Session ID | Summary |
   |---|------------|------------|---------|
   | 1 | 2024-01-08 | abc123...  | Working on auth feature |
   | 2 | 2024-01-07 | def456...  | TypeScript migration |
   | 3 | 2024-01-05 | ghi789...  | Bug fixes in API |
   ```

3. **Prompt user for action** using AskUserQuestion:
   - "View session details" - show more info about a session
   - "Export session" - export to Markdown
   - "Search within session" - search specific session
   - "Done" - exit

4. **If user selects export**:
   - Ask which session number
   - Prompt for export destination and format (see `/export-session`)
   - Execute export

5. **If user selects view**:
   - Show first 1000 chars of the session
   - Offer to export or search within

## Arguments

- `--count N` or `-n N`: Number of sessions to list (default: 10)

## Token Efficiency

- Show brief summaries only (first line of conversation)
- Paginate if more than 10 sessions
- Don't load full session content until user selects one

## Usage Examples

```
/list-sessions
/list-sessions --count 5
/list-sessions -n 20
```

## Error Handling

If no sessions found:
```
No sessions found for this project.
This could mean:
- You haven't used Claude Code in this project yet
- Sessions are stored under a different project path
```
