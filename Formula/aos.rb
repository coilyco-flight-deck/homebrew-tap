class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.114.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.114.0/aos-darwin-arm64"
      sha256 "4df764c2e8b05a96f7c231076771b3d1006ad554cad328ceba79bdb3bebda2c9"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.114.0/aosguard-darwin-arm64"
        sha256 "c45da71ed2dde3159902bbe5147d720642cdc4dca6e0357f9d532fb4690a98af"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.114.0/aos-linux-amd64"
      sha256 "d421859ef501253cd7feb66b71dc0d2454de769ba7a268b38f2ba5504fb9d840"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.114.0/aosguard-linux-amd64"
        sha256 "c99d15cc4e2100376fce5c1f5d8a4db655d6a677eaac2a22f06c3e0f6761d790"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.114.0/aos-linux-arm64"
      sha256 "7abb5f85ec78d326b009bcdeb6b223979ac8d68266eb4ffcdbc6271668eabcdd"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.114.0/aosguard-linux-arm64"
        sha256 "837d21dcaad03cf438adcbc9e44bfa1290b93c65d735c0b370cc8c3d5751fe3e"
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
