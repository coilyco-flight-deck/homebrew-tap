class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.82.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.82.0/aos-darwin-arm64"
      sha256 "d29cb7c26cd1ba5dd141e2cad86017eeaf4506a2504de590f604e5900af9bc18"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.82.0/aos-linux-amd64"
      sha256 "4492a7058a1ca4f820bfd3f7bfd834d90a90ab2f15f37d84341d00b45a9c9e21"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.82.0/aos-linux-arm64"
      sha256 "8375d0247585555c2fe688d9f7de9b0e9978d8eac5edda3d4fb3b418b07ba23f"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
