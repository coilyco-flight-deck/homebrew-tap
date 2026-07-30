class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.140.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.140.0/aos-darwin-arm64"
      sha256 "e0e0916d8d34d834fe011e1137ea13368028f3abea4995ffe79eec80bc5da272"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.140.0/aosguard-darwin-arm64"
        sha256 "f24826a50aa9efef5911094d65a1093c658de2f16cbd48e7ec6b101f12c59b2a"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.140.0/agent-terminal-darwin-arm64"
        sha256 "1abb32c93e08ae47b39248fa32fbf740061a74a28c2d5e0f38a1a7108b846046"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.140.0/aos-linux-amd64"
      sha256 "8c0310fafec620179b80ff67208b4dbb18182ce9d6b7e153901f6fcba1236757"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.140.0/aosguard-linux-amd64"
        sha256 "349d923e5575f1e7c9053c01e38815548a1f33cbd999ec6bff8778401248e837"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.140.0/agent-terminal-linux-amd64"
        sha256 "08fbd79984a1fcf3645fa2625ffd0626b18ea0092c48da3c142a7484e6421c9f"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.140.0/aos-linux-arm64"
      sha256 "82303d37d14efaf7b02905f371d167da0d291ef440412dd348b7cbc0fcd9944d"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.140.0/aosguard-linux-arm64"
        sha256 "e357150a24eb890361b96be8b911ac0a26abf476642df29afa1d9e358f4c8423"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.140.0/agent-terminal-linux-arm64"
        sha256 "7369e52ce5da2e53c565ebe4d90e82532c2607dfffb4ca90c7c03563e9a3e9ea"
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
