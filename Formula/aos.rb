class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.75.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.75.0/aos-darwin-arm64"
      sha256 "1cd36dd9b5c75461c5b0b59bdeda00e37396fb8515013423a2b2b74dac14c2b7"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.75.0/aos-linux-amd64"
      sha256 "374a9f6964e03eeed132e76d24631654f3bd34899d95f4e6630253d9311381a4"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.75.0/aos-linux-arm64"
      sha256 "965bd3ff2b89f212b18eb50c1622fd5c4b39e9709eafb18149a6f799ccb7e9ad"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
