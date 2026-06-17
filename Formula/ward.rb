class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward.git", tag: "v0.29.0", revision: "55e9f95ac1e52bed7da42f91b6562a9604bd6830"
  license "MIT"
  head "https://forgejo.coilysiren.me/coilyco-flight-deck/ward.git", branch: "main"

  depends_on "go" => :build

  def install
    # GOPROXY bypass for fresh cli-guard pseudo-versions. See docs/homebrew-build.md.
    ENV["GOPROXY"] = "direct"
    ENV["GOSUMDB"] = "off"
    ENV["GOPRIVATE"] = "forgejo.coilysiren.me"
    ldflags = "-s -w -X main.Version=v#{version}"
    system "go", "build", "-trimpath",
           "-ldflags", ldflags,
           "-o", bin/"ward",
           "./cmd/ward"

    # ward-kdl is a no-code specverb-gen consumer: build it via the driver from
    # the committed locks (no online `lock` step) and stamp the same version as
    # ward. The driver ref tracks the Makefile so the two never drift.
    ref = File.read("Makefile")[/^REF\s*\?=\s*(\S+)/, 1] || "v0.26.0"
    system "go", "run",
           "forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/cmd/specverb-gen@#{ref}",
           "build",
           "--guardfile", "cmd/ward-kdl/ward-kdl.forgejo.guardfile.kdl",
           "--out", bin,
           "--set-version", "v#{version}"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    assert_match "v#{version}", shell_output("#{bin}/ward-kdl --version")
  end
end
