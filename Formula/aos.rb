class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.62.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.62.0/aos-darwin-arm64"
      sha256 "73e941c7392f2ef7e5a9e86156bfd2bc5b998a12fa7495f5922bb9b5aeffd5ce"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.62.0/aos-linux-amd64"
      sha256 "b45803b794f4a182e50f7e497df45c22ad8ff3b222f5ed984852902a520dda16"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.62.0/aos-linux-arm64"
      sha256 "5070135f427c5b1c672bfe005ea62a80a369134cb966fac8ae74c27066e6f622"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
