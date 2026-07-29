class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.122.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.122.0/aos-darwin-arm64"
      sha256 "17624ffb74a40119fc0379cf921c4fe37e9c78a0d40db106b036519f0b6062c3"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.122.0/aosguard-darwin-arm64"
        sha256 "08c120d7a1a6d83ec0a65ee7b143f3d07d18f411dac08563e4ba7992062853bf"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.122.0/aos-linux-amd64"
      sha256 "689a90a00b534d04be94efc18bfef39a3bc004a5ef2d2230bb242a2592cd93f5"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.122.0/aosguard-linux-amd64"
        sha256 "620cb397d5b5d5bc813d1ade5d34b14be7b258df9f66351da070b2faf8be9b8b"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.122.0/aos-linux-arm64"
      sha256 "25b255d9970a38d8f7a3a67c358b9f78b7b0603c1c655efbeee9fb12c1e76b38"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.122.0/aosguard-linux-arm64"
        sha256 "37b839430777af046aeede0e5c53b30a9a378d5831e3c89f4ef535692f248a51"
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
