# homebrew-tap

Centralized Homebrew tap for `coilyco-flight-deck` tools. One tap to add, every flight-deck CLI behind it. Most `Formula/*.rb` files point at a tag + revision on their upstream forgejo repo; `Formula/ward.rb` tracks tagged release binaries and is bumped here by the upstream release pipeline.

## Install

The tap lives on forgejo, not github.com, so brew can't auto-resolve the URL. Use the explicit-URL `brew tap` form once, then install by formula name:

```sh
brew tap coilyco-flight-deck/tap https://forgejo.coilysiren.me/coilyco-flight-deck/homebrew-tap
brew install coilyco-flight-deck/tap/ward
```

`brew upgrade` picks up new versions after each upstream release bumps the formula here.

## Formulae

* `Formula/ward.rb` - `coilyco-flight-deck/ward` - the `ward` cli-guard consumer, downloaded from the tagged release assets and verified per platform.
* `Formula/repo-recall.rb` - `coilyco-flight-deck/repo-recall` - local dev dashboard indexing Claude Code session history against your repos.
* `Formula/session-lattice.rb` - `coilyco-flight-deck/session-lattice` - materialized-view service over Claude session data (embedded DuckDB).
* `Formula/session-lattice-puller.rb` - `coilyco-flight-deck/session-lattice` - companion puller service for session-lattice (ships only a brew service).

## Release flow

An upstream repo cuts a tag, then its release pipeline rewrites the matching formula in this repo via the forgejo Contents API. For `ward` that means refreshing the tagged release URL and checksum pins for the platform binaries. Once the bump lands on `main`, `brew upgrade` picks it up. The tap itself holds no release pipeline - it is the write target for the upstream ones.

## Commands

Dev commands are declared in [`.ward/ward.yaml`](.ward/ward.yaml). Route them through ward, not bare `brew`.

## See also

- [AGENTS.md](AGENTS.md) - agent-facing operating rules.
- [docs/FEATURES.md](docs/FEATURES.md) - inventory of what ships today.
- [docs/homebrew-build.md](docs/homebrew-build.md) - build-time notes (GOPROXY bypass).
- [.ward/ward.yaml](.ward/ward.yaml) - allowlisted commands.
