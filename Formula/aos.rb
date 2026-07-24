class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.43.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.43.0/aos-darwin-arm64"
      sha256 "773cf04c5423899806586ab251760f940bfbc096b5ec8cf0be7a53525a701ffa"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.43.0/aos-linux-amd64"
      sha256 "a20efdbba8b5d169aad675f592c82d73b1fdf6e1ca80b4ec8c535b9cc1ff1c86"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.43.0/aos-linux-arm64"
      sha256 "543662d66623e7b3069a91197e6d7695a21e743395bed812eda8fec5ab81fd74"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
