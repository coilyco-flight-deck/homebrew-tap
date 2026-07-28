class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.115.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.115.0/aos-darwin-arm64"
      sha256 "fcd1c07d3cbbdb24dad63766a723ff5c9f609d15ea1774ea8d72720390c083be"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.115.0/aosguard-darwin-arm64"
        sha256 "78dd278e0faa083c630a7b9520699f354bbb38ec73c03d1689e3eeeff2e45d99"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.115.0/aos-linux-amd64"
      sha256 "716e1ecd7ebe73b11893cbd94ef96309dfa875aa38fe73a13b2c3a844e38a78a"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.115.0/aosguard-linux-amd64"
        sha256 "ca47e7e0ce38be598b5ebc32a14ccbd3b7d7c10a7d90f16b5b8fb54e03489f14"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.115.0/aos-linux-arm64"
      sha256 "e34d5a535a61101072dd890b8c94c7231258780c33153d9867dcb73b8be158fa"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.115.0/aosguard-linux-arm64"
        sha256 "39a594ccd57aa95ac95bb7f4c465d16ce5976bd772190d0132307bd7b7e72c43"
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
