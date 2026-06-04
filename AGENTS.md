# Agent instructions for `coilyco-flight-deck/homebrew-tap`

Orientation for fresh Claude / mobile sessions. Keep this short.

## What this repo is

The centralized Homebrew tap for `coilyco-flight-deck/*` tools. Each `Formula/*.rb` points at a tag + revision on its upstream forgejo repo.

Active formulae:

- `Formula/ward.rb` - tracks `coilyco-flight-deck/ward` releases.
- `Formula/repo-recall.rb` - tracks `coilyco-flight-deck/repo-recall` releases.
- `Formula/session-lattice.rb` - tracks `coilyco-flight-deck/session-lattice` releases.
- `Formula/session-lattice-puller.rb` - companion service formula; pinned in lockstep with `session-lattice.rb`.

## Release flow

Upstream repos cut a tag. Their release pipeline rewrites the `url "..."` line (tag + revision) of the matching formula here via the forgejo Contents API. Once the bump lands on `main`, `brew upgrade` picks it up. This repo holds no release pipeline of its own - it is the write target for the upstream ones.

## Forbidden ops

- Do not hand-edit a formula's `url` / `tag` / `revision` to race ahead of the upstream release pipeline. The pipeline is the source of truth for the version pin.
- Do not bypass commit hooks (`--no-verify`).

Editing the install/test logic of a formula (e.g. build flags, staging files) is fine. The upstream pipeline only rewrites the version-pin `url` line.

## Privileged ops

Anything privileged routes through `coily` wrappers. Bare `brew`, `gh`, `aws`, `kubectl`, etc. are denied by the harness.

## Git workflow

- Commit to `main`, push after each commit. No PRs unless asked.
- Canonical history lives on forgejo; the GitHub mirror (if any) stays PR-gated.

## Commands

Route every dev command through coily, which reads [`.coily/coily.yaml`](.coily/coily.yaml). Add new verbs to that file before invoking them.

## See also

- [README.md](README.md) - human-facing intro and install steps.
- [docs/FEATURES.md](docs/FEATURES.md) - inventory of what ships today.
- [.coily/coily.yaml](.coily/coily.yaml) - allowlisted commands. Agents route through coily, not bare `brew`.
