class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.81.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.81.0/aos-darwin-arm64"
      sha256 "9e908f008a888ea629435d9ed749c392b3874a2a14a81559cb25edbfac09b5fc"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.81.0/aos-linux-amd64"
      sha256 "0e19958a94a78908db4f73bc9fd4e21c33b6da8998b1a210e1fe4ff619efcf4d"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.81.0/aos-linux-arm64"
      sha256 "5cf8127a3dca8c5427094ad8aea1033cb5b387fc9d19e6e188cb681a9993adbb"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
