# homebrew-tap

Centralized Homebrew tap for `coilyco-flight-deck` tools. One tap to add, every flight-deck CLI behind it. Each `Formula/*.rb` points at a tag + revision on its upstream forgejo repo and is bumped here by that repo's release pipeline.

## Install

The tap lives on forgejo, not github.com, so brew can't auto-resolve the URL. Use the explicit-URL `brew tap` form once, then install by formula name:

```sh
brew tap coilyco-flight-deck/tap https://forgejo.coilysiren.me/coilyco-flight-deck/homebrew-tap
brew install coilyco-flight-deck/tap/ward
```

`brew upgrade` picks up new versions after each upstream release bumps the formula here.

## Formulae

* `Formula/ward.rb` - `coilyco-flight-deck/ward` - the `ward` cli-guard consumer.
* `Formula/repo-recall.rb` - `coilyco-flight-deck/repo-recall` - local dev dashboard indexing Claude Code session history against your repos.

## Release flow

An upstream repo cuts a tag, then its release pipeline rewrites the `url "..."` line (tag + revision) of the matching formula in this repo via the forgejo Contents API. Once the bump lands on `main`, `brew upgrade` picks it up. The tap itself holds no release pipeline - it is the write target for the upstream ones.

## Commands

Dev commands are declared in [`.coily/coily.yaml`](.coily/coily.yaml). Route them through coily, not bare `brew`.

## See also

- [AGENTS.md](AGENTS.md) - agent-facing operating rules.
- [docs/FEATURES.md](docs/FEATURES.md) - inventory of what ships today.
- [docs/homebrew-build.md](docs/homebrew-build.md) - build-time notes (GOPROXY bypass).
- [.coily/coily.yaml](.coily/coily.yaml) - allowlisted commands.
