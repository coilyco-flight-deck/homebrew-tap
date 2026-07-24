class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.67.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.67.0/aos-darwin-arm64"
      sha256 "dfc7958448f3a91541c75ecbd13c14c1b79bb901b59cd50677257eb925d4ce0a"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.67.0/aos-linux-amd64"
      sha256 "d97fbb3fed9059e582312231773dd738635f8667d315555869d16b175767cd11"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.67.0/aos-linux-arm64"
      sha256 "b539c065cc86d17f39fa47c9a2221f21f99d739d5e8b0f18541c71634914827b"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
