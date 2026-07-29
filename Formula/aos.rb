class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.128.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.128.0/aos-darwin-arm64"
      sha256 "5c02f8c576c0ba76204a053e3a20f0556ad99fc6ccd70d1d256354feb2c36613"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.128.0/aosguard-darwin-arm64"
        sha256 "96274c39b60665063783a4a00cbedf878a6fc747cbcdbb5344046b8a3f23f335"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.128.0/aos-linux-amd64"
      sha256 "049a36044a554809ac1cd0b2879f784c4dc62f394034a43868042030faee2e09"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.128.0/aosguard-linux-amd64"
        sha256 "6bb3ad10c0b26bacf7d260594425577531e610330cb976173b2b938f754deb14"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.128.0/aos-linux-arm64"
      sha256 "c199a944ce24579a3b05b14ce84d5259e06ed1dcd51462ea1d2487845d26d4d3"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.128.0/aosguard-linux-arm64"
        sha256 "74829fb77c5510cd783859d2248a22f604135be32836b03cdc469f47842194f2"
      end
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
    resource("aosguard").stage { bin.install Dir["aosguard-*"].first => "aosguard" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
    assert_match version.to_s, shell_output("#{bin}/aosguard --version")
  end
end
