class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.69.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.69.0/aos-darwin-arm64"
      sha256 "0ce4df17ad7db875f6a9fd6cf4e39a712c41ee8c437ac9433e7bc0eb9664776c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.69.0/aos-linux-amd64"
      sha256 "4f2b3481d95ee31307daae0d9010096b9771dec3e11f79d5e586ea272f01c9fd"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.69.0/aos-linux-arm64"
      sha256 "b375da939e12d2b0630d1f53507ba17ff441ac4bc91ce964e240c8eaba1bc8dd"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
