class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.53.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.53.0/aos-darwin-arm64"
      sha256 "844bd08bce368d7a160d535ad01e6f091a29f651901c9d8363aad43805ae3a92"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.53.0/aos-linux-amd64"
      sha256 "008277cf6de968b189179da60071ccabf36010e97697fa7fb5f10909f2e26f27"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.53.0/aos-linux-arm64"
      sha256 "191394363530292a96f1dfb225ac3b3c5759b9161fbf4e34c928381f5ec3ad12"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
