class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward.git", tag: "v0.8.0", revision: "08b049653ae0aca2542124d26ff521b8a10f2912"
  license "MIT"
  head "https://forgejo.coilysiren.me/coilyco-flight-deck/ward.git", branch: "main"

  depends_on "go" => :build

  def install
    # GOPROXY bypass for fresh cli-guard pseudo-versions. See docs/homebrew-build.md.
    ENV["GOPROXY"] = "direct"
    ENV["GOSUMDB"] = "off"
    ldflags = "-s -w -X main.Version=v#{version}"
    system "go", "build", "-trimpath",
           "-ldflags", ldflags,
           "-o", bin/"ward",
           "./cmd/ward"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
  end
end
