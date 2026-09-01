# stylist releases

Prebuilt binaries for stylist, a tone and quality checker for AI-generated assets. See https://getstylist.dev.

This repo has no product source code — that stays private. It carries
release binaries, a pre-commit hook manifest, and a Claude Code plugin.
Each release matches a tagged version of the stylist CLI and server.

## Install

Download the binary for your platform from the latest release:
https://github.com/lukedevops/stylist-releases/releases/latest

Or pull the Docker image:

```
docker pull ghcr.io/lukedevops/stylist:latest
```

## Claude Code plugin

Adds a `PostToolUse` hook that checks every file Claude writes or edits
against your house style guide, feeding violations back so it
self-corrects before you see them.

```
/plugin marketplace add lukedevops/stylist-releases
/plugin install stylist
```

Requires the `stylist` binary on `PATH` (see Install above) and a
ruleset. See [`plugins/stylist/README.md`](plugins/stylist/README.md)
for details, including the licensed dashboard/hosted option.

Docs: https://getstylist.dev/docs
