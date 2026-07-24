class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.31.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.31.0/aos-darwin-arm64"
      sha256 "d02c1f5cdad5e073227925bb05d536ce77b9c5ac8f169db5f1a36a99adb1b0f2"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.31.0/aos-linux-amd64"
      sha256 "124ef62679f6d5b71255a6c107870b3ed059a00ffcaa3b1c0e09951747f5e349"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.31.0/aos-linux-arm64"
      sha256 "c5724472ce714b8af170502a8acd0e3db96a3c9f951f2867c32241d1d3f5196c"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
