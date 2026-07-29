class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.123.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.123.0/aos-darwin-arm64"
      sha256 "1fdbc306a9346fa3fbef0fcfebb8c4064747849b01a6f0369ccc4cdb01c99c61"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.123.0/aosguard-darwin-arm64"
        sha256 "0a213cc4e4f4936338b13cd851cdb2562a6b4f02dba7486496e7b7cd0bd731bf"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.123.0/aos-linux-amd64"
      sha256 "b122cea6e4b286e2ca30e54ee11dc9b98726131b748ff91691048769f9b27f8f"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.123.0/aosguard-linux-amd64"
        sha256 "2c446b585371a7c136ceb069fbf3d9b3abaf63dd9e6434f882197cfdf63af734"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.123.0/aos-linux-arm64"
      sha256 "179a28a34dd5e8c9c03576e08a30d1649781f248981b001cf5fd8b8731641296"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.123.0/aosguard-linux-arm64"
        sha256 "9ae303a2441c80bdaaf02a5021b59f69624ab57129e3834e4b519bae5d670058"
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
