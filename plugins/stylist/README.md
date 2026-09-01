# stylist

Checks AI-generated assets (HTML, Markdown, Word, PowerPoint, SVG, images)
against your house style guide — brand colors, allowed fonts, banned/required
terms, outdated logos, image resolution — and feeds any violation back to
Claude so it fixes its own output before you ever see it.

## Requirements

This plugin only wires up the hook. It calls a `stylist` binary that must be
on your `PATH` — download it from the latest release at
https://github.com/lukedevops/stylist-releases/releases/latest, or
`docker pull ghcr.io/lukedevops/stylist:latest`. Full install options:
https://getstylist.dev/docs/getting-started.

You'll also need a ruleset (a YAML file describing your brand rules) — see
https://getstylist.dev/docs/rulesets for the format, or start from
`stylist.yaml` in your project root once you have one.

## What this plugin does

Installs a `PostToolUse` hook that runs on every `Write`/`Edit`/`MultiEdit`.
Checkable assets are checked against your ruleset; blocking violations are
returned to Claude on its next turn so it corrects the file itself, while
advisory-only results (like outdated-logo detection) are left silent for the
agent and only surface in the dashboard or CI. If `stylist` isn't installed
or the check can't run, the hook fails open — it never blocks your work.

If your ruleset declares `tone:` guidance (voice/tone judged by an LLM), add
`tone_agent: claude-cli` to `.stylist.yaml` (requires stylist v1.0.2+) to run
that judge through the `claude` CLI you already have — no server, no API
key. See https://getstylist.dev/docs/rulesets#check-semantics.

## Enterprise: dashboard & hosted option

The checker above is free to run everywhere. If you want conformance trends,
pass-rate history, and per-repo/per-person breakdowns across a whole team,
that's the licensed **dashboard** — self-hosted with your own license key, or
we'll run it for you. See https://getstylist.dev or use the "request access"
form there to talk to us about enterprise or hosted plans.
