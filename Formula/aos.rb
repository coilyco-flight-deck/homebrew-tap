class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.107.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.107.0/aos-darwin-arm64"
      sha256 "eb0f851eb966a6692de29c25606f0b586bbf9ad625eb48868f7a1fa30e049b94"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.107.0/aosguard-darwin-arm64"
        sha256 "0f81a5e17b885f13ba29bc32e49caa2c3ce11bc82ae77d2566bcfd4fb99d6141"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.107.0/aos-linux-amd64"
      sha256 "5ebf6f16eed01e6c06a31b9a433600b5cc0e48d507139ed0af7b146a4931808c"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.107.0/aosguard-linux-amd64"
        sha256 "7fbf64e0e535d72f87bc7ba304b6619d98eaf17864b3b613424ab3f615b8604c"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.107.0/aos-linux-arm64"
      sha256 "f20600a56b6b459f38203ab5bd75a19c1a43776f4e9e26b279d7ab2ba2e7e741"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.107.0/aosguard-linux-arm64"
        sha256 "debb63e933dba3ab3f5cb239fa204d24c0743276bd07d11e652fd1dd56c75868"
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
