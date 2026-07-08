# Homebrew build notes

## GOPROXY bypass

cli-guard has no semver tags yet, so source-built consumers pin via
pseudo-version. `proxy.golang.org` 403s the fresh pseudo-version on
first fetch even though the upstream tarball is reachable. Affected
formulae set `GOPROXY=direct` and `GOSUMDB=off` in the brew sandbox to
bypass the proxy for module fetches.

This note no longer applies to [Formula/ward.rb](../Formula/ward.rb):
`ward` now downloads a tagged release binary instead of building from
source. It still applies to any other cli-guard consumer formula that
builds from Go source.
