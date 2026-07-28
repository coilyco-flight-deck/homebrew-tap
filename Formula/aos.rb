class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.113.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.113.0/aos-darwin-arm64"
      sha256 "e9ef448479a1f375b8fc9529f0ec1db2fb51f6ea69a9dfbd566d7dc56efcdd41"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.113.0/aosguard-darwin-arm64"
        sha256 "5844311477ec9a2bd0f9b916a061bd85151c499799bbf23a4a7a63c96903f5ab"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.113.0/aos-linux-amd64"
      sha256 "c349df5af09802d718aa059bd4fe52d3f104eb3bffb4e93f0476967d795a38d3"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.113.0/aosguard-linux-amd64"
        sha256 "22ee62b1bd4514f143317673bf3a3016db507fff3ca817dcb31ae30507020f0e"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.113.0/aos-linux-arm64"
      sha256 "c2ece1bbb01503937e81bce3db3474a2be641cb3a0dad47aa0465de62b3b8d67"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.113.0/aosguard-linux-arm64"
        sha256 "b8c10bf4c263f2a7987a9429f2e42ef6e9f833e3fa3e9edf5ebd3c65e53ef4ce"
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
