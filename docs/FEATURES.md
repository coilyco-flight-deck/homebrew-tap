# Features

Baseline inventory of what `coilyco-flight-deck/homebrew-tap` ships today. Use this as the reference point for scope changes. When a feature is added, removed, or materially reshaped, update the relevant section so the diff against this file shows scope drift over time.

Last full sweep: 2026-06-03.

## Formulae

Tap installed via `brew tap coilyco-flight-deck/tap https://forgejo.coilysiren.me/coilyco-flight-deck/homebrew-tap`. Individual formulae installed with `brew install coilyco-flight-deck/tap/<formula>`.

- **[Formula/ward.rb](../Formula/ward.rb)** - tracks `coilyco-flight-deck/ward` tag + revision. A contributor-facing cli-guard consumer. Builds from source with the GOPROXY bypass (see below).

## Release bump automation

This repo holds no workflows. Each upstream tool's release pipeline writes the version-pin bump into the matching formula here via the forgejo Contents API:

- **`coilyco-flight-deck/ward`** `.github/workflows/release.yml` - on each release, rewrites the `url` line of [Formula/ward.rb](../Formula/ward.rb) in this repo.

## Build notes

- **[docs/homebrew-build.md](../docs/homebrew-build.md)** - GOPROXY bypass for cli-guard consumer formulae. cli-guard has no semver tags yet, so `proxy.golang.org` 403s the fresh pseudo-version; affected formulae set `GOPROXY=direct` / `GOSUMDB=off` in the brew sandbox.

## See also

- [README.md](../README.md) - human-facing intro and quickstart.
- [AGENTS.md](../AGENTS.md) - agent-facing operating rules.
- [.coily/coily.yaml](../.coily/coily.yaml) - allowlisted commands.
