class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.35.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.35.0/aos-darwin-arm64"
      sha256 "1c37220c5f55ce6a4c2b92687825327a9cd369d51b156d574f197c4a1e87b866"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.35.0/aos-linux-amd64"
      sha256 "c410e39c98dbc9ed5c55883b80f03e5f9abe80f78fa65dc041980e435057f761"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.35.0/aos-linux-arm64"
      sha256 "6c4623309fd94e1d3cb2cf146889f101f89cd2fe840c7591d0b03b058f70685e"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
