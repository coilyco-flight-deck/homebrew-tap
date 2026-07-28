class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.105.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.105.0/aos-darwin-arm64"
      sha256 "d82070ed7376d225de4304e44d990f4cc709ea4fdf64f612c87c76b29a929d19"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.105.0/aosguard-darwin-arm64"
        sha256 "4be5edb290b2ee2cd9aa82be62ca11876ba6b1684525f0a0d924bb834d3f2638"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.105.0/aos-linux-amd64"
      sha256 "5fb3435963b87f8b5e365c12f0cb6e66f9432f8c2bc97b55b03b5f22a7c9fccd"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.105.0/aosguard-linux-amd64"
        sha256 "22b38dde9f4a9ccf3e998919405494550477c3644639e3f8a068427db67198f4"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.105.0/aos-linux-arm64"
      sha256 "69a22ff1a60e5f1a8498b7641e05305e63f07268b7297b2d60e43c38ee3f60cb"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.105.0/aosguard-linux-arm64"
        sha256 "ec882dd3ccb3e2cb018009fe4b34bb16f41bba92e242a45064d4e8e6923f14b4"
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
