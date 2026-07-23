class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.23.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.23.0/aos-darwin-arm64"
      sha256 "f032bc176d6395965724d3c4b969af2491786429537cf735e7ea746a9c79f9e9"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.23.0/aos-linux-amd64"
      sha256 "9eb3bbc06a54f6e5ca3e509c796206ea37d5b796ba2c79a8d604a355604b248e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.23.0/aos-linux-arm64"
      sha256 "8517dee39b6017791434568fe758dabacc4482c0e0d833503ce32deef21e340f"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
