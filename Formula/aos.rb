class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.57.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.57.0/aos-darwin-arm64"
      sha256 "fac7397cd3a28fe946197d370f5330987e60859db703d6e2e7ab47bbade52681"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.57.0/aos-linux-amd64"
      sha256 "e62baee6dcef5ec887749d929548a4b81abfd71dff0e04e8157b05b3c09d9e7e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.57.0/aos-linux-arm64"
      sha256 "c7dbb8b32fd21456f85116583cd8647d4b013a89935848b7399113eadbaa0f40"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
