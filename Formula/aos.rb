class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.7.0/aos-darwin-arm64"
      sha256 "60a87c68908325c0cc0095cf985657354feb889dbe578200ead1a1933b6e4950"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.7.0/aos-linux-amd64"
      sha256 "9f65dbd520af7f4ac34edc33f3d2baad1409fdb38007156c3cc03e4d24509301"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.7.0/aos-linux-arm64"
      sha256 "9a7abb3c6e0dc7e06fde512279446feb248f3bdceb4aed3da5450f66b25692be"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
