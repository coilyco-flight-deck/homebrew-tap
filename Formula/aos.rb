class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.65.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.65.0/aos-darwin-arm64"
      sha256 "9d3a3d0b1d5848ca6e0cc5c470f10e104547f852259ed9b984055b4e66a209a5"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.65.0/aos-linux-amd64"
      sha256 "f3f6b99fb22148f1453878d75e168326fe132ff1776767bca848f258302105d6"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.65.0/aos-linux-arm64"
      sha256 "619a5bdd0e321504f9f67791253558645dd85da3efac47acd05ac28e1674d076"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
