class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.47.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.47.0/aos-darwin-arm64"
      sha256 "68cec575f3b4aa495350b444b5a31832f4814b11ee5572c0cef414dcb859f79f"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.47.0/aos-linux-amd64"
      sha256 "9166aa0a5d80e195011e2cf1c2e1e80dfcde828b81e9723ed254ba655735f2b3"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.47.0/aos-linux-arm64"
      sha256 "9c78986d57e5a9c2605669c56a35404592a58a2f76bfbcb1420f10d19455119e"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
