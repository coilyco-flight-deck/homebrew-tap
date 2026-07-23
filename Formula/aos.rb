class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.19.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.19.0/aos-darwin-arm64"
      sha256 "1f5bcbd59e3852c30d8c80cb25013a94deb0f0d0520dacb3ed7697b1a0c15e3c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.19.0/aos-linux-amd64"
      sha256 "82e6944c571abcf34980f2e4bdc80b2198d5f05fdf79d9c6c8371d6d0181f7c3"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.19.0/aos-linux-arm64"
      sha256 "574ee01a9ecbd11ee3d9ef53a6fc3d43635a7275557e4f29c45a4c480745e8d1"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
