class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.10.0/aos-darwin-arm64"
      sha256 "98855f2096412bbb5906d014d3ab70105a35404a10d2e126c0834df30f619652"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.10.0/aos-linux-amd64"
      sha256 "2bc4f772c573f63ec4df5371e2f280100bffc1aef9a27d933cff443137b77a18"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.10.0/aos-linux-arm64"
      sha256 "257581d2c227f3590bb35b0cc310d45807134aac9b5cd796f6746b3018053835"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
