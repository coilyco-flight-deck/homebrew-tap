class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.44.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.44.0/aos-darwin-arm64"
      sha256 "4c5781d6dfa60f2e4ce83cc115f7403dac45a029479449bacb474c3e2073b222"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.44.0/aos-linux-amd64"
      sha256 "249f1edb8948935333dc7c54e8337360fc13a21fb30c59ba6f71afa68f587974"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.44.0/aos-linux-arm64"
      sha256 "725ece8c3512022b59e9d08c5baa1bee1640376d14175559e77f3960fc8053d3"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
