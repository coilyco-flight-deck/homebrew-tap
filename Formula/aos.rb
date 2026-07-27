class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.100.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.100.0/aos-darwin-arm64"
      sha256 "5ad1aafb753c00fa5c1213340958a4b5172e0850afeeaf74a9604d19222754f6"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.100.0/aosguard-darwin-arm64"
        sha256 "36fb92862763fbe1aef30337d3ead3de8048ba6c567a4abb6808377363bdf36e"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.100.0/aos-linux-amd64"
      sha256 "1593dc9f6348809945af9255fec49892c6fa2d3a7075d0b84cbc784f81ddf5e2"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.100.0/aosguard-linux-amd64"
        sha256 "4e4482793afb438dc518cdc216656f1c94b57b0e9b602bc4b38482dd14d0dad6"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.100.0/aos-linux-arm64"
      sha256 "417f4f79fbe94382ecb57a1f016742141eb144edc897b00c1a0116a91aa250c0"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.100.0/aosguard-linux-arm64"
        sha256 "2542d209d223cbe6d8d54ec5e2b452e58d3c0f59510e8ddf044c7982e066682e"
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
