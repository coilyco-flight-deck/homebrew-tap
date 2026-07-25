class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.76.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.76.0/aos-darwin-arm64"
      sha256 "e55f30bc0d5569636f4c8326c6a8457bf37a5b5818cd8d53d8e4ba693297c851"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.76.0/aos-linux-amd64"
      sha256 "dc0be1498e352461f0b72d2fad7e1e25c4d48680c3124fe973ffec5355c56da6"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.76.0/aos-linux-arm64"
      sha256 "f629c58a67fafcf65e00a9d45267ea157862aad9b3848673c9add7581d5de4c4"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
