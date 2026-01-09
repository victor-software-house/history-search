# history-search

Claude Code plugin for searching and exporting previous session history to maintain context continuity.

## Features

- **Search History**: Semantic search through past sessions in current project
- **List Sessions**: Browse recent sessions with summaries
- **Export Sessions**: Export conversations to Markdown with flexible output options
- **Context Finder**: Proactive agent that finds relevant past discussions

## Prerequisites

Requires `claude-conversation-extractor` CLI tool:

```bash
pipx install claude-conversation-extractor
```

## Installation

Copy to your plugins directory:

```bash
cp -r history-search ~/.claude/plugins/
```

Or enable via Claude Code:

```bash
claude --plugin-dir /path/to/history-search
```

## Commands

| Command | Description |
|---------|-------------|
| `/search-history "query"` | Search past sessions for relevant content |
| `/list-sessions` | List recent sessions with option to export |
| `/export-session` | Export a session to processed Markdown |

## Agent

The `context-finder` agent triggers proactively when you ask about something you've worked on before:

- "We discussed authentication last week..."
- "How did we implement that feature?"
- "Find where we talked about..."

## Token Efficiency

This plugin is designed to minimize token usage:

- Returns ~500 char snippets, not full conversations
- Uses semantic search to find most relevant content
- Scopes to current project by default
- No automatic hooks that run on every event

## License

MIT
