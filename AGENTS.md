# Agent instructions for `coilyco-flight-deck/homebrew-tap`

Orientation for fresh Claude / mobile sessions. Keep this short.

## What this repo is

The centralized Homebrew tap for `coilyco-flight-deck/*` tools. Most `Formula/*.rb` files point at a tag + revision on their upstream forgejo repo; `Formula/ward.rb` tracks tagged release binaries instead.

Active formulae:

- `Formula/ward.rb` - tracks `coilyco-flight-deck/ward` releases by downloading the tagged platform binaries and verifying them.
- `Formula/repo-recall.rb` - tracks `coilyco-flight-deck/repo-recall` releases.
- `Formula/session-lattice.rb` - tracks `coilyco-flight-deck/session-lattice` releases.
- `Formula/session-lattice-puller.rb` - companion service formula; pinned in lockstep with `session-lattice.rb`.

## Release flow

Upstream repos cut a tag. Their release pipeline rewrites the matching formula here via the forgejo Contents API. `ward` refreshes its release-asset URLs and checksums; the other formulae still pin upstream tag + revision. Once the bump lands on `main`, `brew upgrade` picks it up. This repo holds no release pipeline of its own - it is the write target for the upstream ones.

## Forbidden ops

- Do not hand-edit a formula's `url` / `tag` / `revision` to race ahead of the upstream release pipeline. The pipeline is the source of truth for the version pin.
- Do not bypass commit hooks (`--no-verify`).

Editing the install/test logic of a formula (e.g. build flags, staging files) is fine. The upstream pipeline only rewrites the version-pin `url` line.

## Privileged ops

Anything privileged routes through `ward` (contributor verbs: exec/git/pkg/audit/hook) or `ward-kdl ops` (operator surface: aws/ssm, tailscale, kubectl, forgejo). Bare `brew`, `gh`, `aws`, `kubectl`, etc. are denied by the harness.

## Git workflow

- Commit to `main`, push after each commit. No PRs unless asked.
- Canonical history lives on forgejo; the GitHub mirror (if any) stays PR-gated.

## Commands

Route every dev command through ward, which reads [`.ward/ward.yaml`](.ward/ward.yaml). Add new verbs to that file before invoking them.

## See also

- [README.md](README.md) - human-facing intro and install steps.
- [docs/FEATURES.md](docs/FEATURES.md) - inventory of what ships today.
- [.ward/ward.yaml](.ward/ward.yaml) - allowlisted commands. Agents route through ward, not bare `brew`.
