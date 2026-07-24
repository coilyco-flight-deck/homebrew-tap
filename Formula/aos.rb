class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.42.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.42.0/aos-darwin-arm64"
      sha256 "bfe2284caf29aaeddd96ba24ecd2cb0accf972d582fa5021407ee13508add57f"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.42.0/aos-linux-amd64"
      sha256 "6fc38a6b431aae3d78d6197589a88aa8aeb9cca50d7bee9a31711709ef1c7938"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.42.0/aos-linux-arm64"
      sha256 "13c02926bb8e22caf8de9c5f8717528ac62dac18915cf9390c235f1ef3c47d72"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
