class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.41.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.41.0/aos-darwin-arm64"
      sha256 "eb9d0e1c5923f0f1594af5a2f75a35e1d59508b46b5eb6be47d625d1840043a2"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.41.0/aos-linux-amd64"
      sha256 "37b8c8e49baf7d7f104b2ef6f8f0c7777014daf9c34df9689fb5d95b961ca95e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.41.0/aos-linux-arm64"
      sha256 "3907a8114daa650ebb4c275b5897984fc7b695a819a3a1df3aee2fa40050eb86"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
