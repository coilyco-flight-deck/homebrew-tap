class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.137.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.137.0/aos-darwin-arm64"
      sha256 "7048c2349f5e3703883ff768c5a2f10b38c91e67267667ca0d6fc2e0004d0170"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.137.0/aosguard-darwin-arm64"
        sha256 "41419695f9cc5f3d0364f9fef950fb940a47dd3db722f5a84646a4da381d0321"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.137.0/agent-terminal-darwin-arm64"
        sha256 "a443a45c3b5c20d71188ec8d521e31f033618e3faba80e0bc28530e405e180d9"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.137.0/aos-linux-amd64"
      sha256 "2836013e844b88a5bf0d0bf25b1c9a690b74da34fc01884b16620ec9b0a3e5af"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.137.0/aosguard-linux-amd64"
        sha256 "35421f0ac22aa46fb88129d44999fbee85331ee5cae9d095b22822e23955a9ce"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.137.0/agent-terminal-linux-amd64"
        sha256 "111ced79ba256fc2ccd1d0dababb4e02dc857f558523defb2ffef732f916b637"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.137.0/aos-linux-arm64"
      sha256 "03f23c0ee44485f2154e77a96cd5f05177e0361fb5dc552f4db376f77628d062"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.137.0/aosguard-linux-arm64"
        sha256 "6160ebf42693cefc86889ff8ec0a1e5dfdc1ab3492d661e3d9a811ab3eea7072"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.137.0/agent-terminal-linux-arm64"
        sha256 "92a274155fe8374d50c16080dc37c1a2ea0273acc1987eda9ce89135ad2a0d28"
      end
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
    resource("aosguard").stage { bin.install Dir["aosguard-*"].first => "aosguard" }
    resource("agent-terminal").stage { bin.install Dir["agent-terminal-*"].first => "agent-terminal" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
    assert_match version.to_s, shell_output("#{bin}/aosguard --version")
    assert_match version.to_s, shell_output("#{bin}/agent-terminal --version")
  end
end
