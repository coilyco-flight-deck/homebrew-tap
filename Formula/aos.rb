class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.28.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.28.0/aos-darwin-arm64"
      sha256 "14de93504a609ffc21473d47a5cab88112b1c5ab6a5ed001e52627c4b7f12d43"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.28.0/aos-linux-amd64"
      sha256 "6bba543107222f707e12bdec9cff3312c23ee1fb51b832a508e76600105076d2"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.28.0/aos-linux-arm64"
      sha256 "9299f60e5f8182c4d3c85f81822eb8516a1821669f54d3dd0177f5b1674a7443"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
