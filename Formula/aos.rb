class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.108.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.108.0/aos-darwin-arm64"
      sha256 "8ce211e6efd9d1dc0f81d3dd79deff3afacc9df846a38c1c78204182d693644f"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.108.0/aosguard-darwin-arm64"
        sha256 "ce01d7793cb9f9e783b6a4195fe7aa9ba80b81210b7bbbecbca19fc465456c12"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.108.0/aos-linux-amd64"
      sha256 "66cfb95b83a025e8f921f613267991d7d1ffec0ca60deb7f6495a3a788459c01"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.108.0/aosguard-linux-amd64"
        sha256 "80425a63027659a33fec2ffb085e209886a11d43968f908c5c5f22456c77faab"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.108.0/aos-linux-arm64"
      sha256 "326c9dc63a2149c9131d03b00f7f740e1b2315efa34ae8effda33f7d52cf6545"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.108.0/aosguard-linux-arm64"
        sha256 "12d99998bf4597e3f8c7dc084481245ea6389dddf46ff08422198c2879525a53"
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
