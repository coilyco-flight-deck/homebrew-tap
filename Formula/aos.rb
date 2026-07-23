class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.20.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.20.0/aos-darwin-arm64"
      sha256 "1c87937b70d50ef5ceb89ffee3ea56bf06524a0e2c43220e1586a1698c51cb7c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.20.0/aos-linux-amd64"
      sha256 "b26f6285f3ea10b5bfb7b86b4ad2401b563c2092b5ed972e6f87ad59fdfd3267"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.20.0/aos-linux-arm64"
      sha256 "88eda4f722bfaeb8e0df47e58abb2047d75873d105fded23d911464a855db122"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
