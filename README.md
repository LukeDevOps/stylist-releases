# stylist releases

Prebuilt binaries for stylist, a tone and quality checker for AI-generated assets. See https://getstylist.dev.

This repo has no product source code — that stays private. It carries
release binaries, a pre-commit hook manifest, and a plugin for both
Claude Code and Codex CLI. Each release matches a tagged version of the
stylist CLI and server.

## Install

Download the binary for your platform from the latest release:
https://github.com/lukedevops/stylist-releases/releases/latest

Or pull the Docker image:

```
docker pull ghcr.io/lukedevops/stylist:latest
```

## Plugin: Claude Code & Codex CLI

Adds a `PostToolUse` hook that checks every file the agent writes or edits
against your house style guide, feeding violations back so it
self-corrects before you see them. Same plugin package, two install
commands depending on which CLI you use.

**Claude Code** (submitted for Anthropic's curated marketplace, pending
approval — until then, or if you'd rather not wait, install directly):

```
/plugin marketplace add lukedevops/stylist-releases
/plugin install stylist
```

**Codex CLI** (self-serve only for now — Codex's curated Plugin Directory
doesn't run bundled hooks yet, so this is installed directly):

```
codex plugin marketplace add lukedevops/stylist-releases
codex plugin install stylist
```

Requires the `stylist` binary on `PATH` (see Install above) and a
ruleset. See [`plugins/stylist/README.md`](plugins/stylist/README.md)
for details, including the licensed dashboard/hosted option.

Docs: https://getstylist.dev/docs
