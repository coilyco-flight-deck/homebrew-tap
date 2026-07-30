class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.136.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.136.0/aos-darwin-arm64"
      sha256 "362331ceb7dbb735b0ad0f670574e5928ec83c647679381228171536315012ce"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.136.0/aosguard-darwin-arm64"
        sha256 "3c951a38a1d693ce9666dda4f95da4c4b17b7dbb062dff750076463862cf00b4"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.136.0/agent-terminal-darwin-arm64"
        sha256 "661f456ad1573b897463b974770104fe20fd05f8e4ed0cf01d2ea5f9c81b60ab"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.136.0/aos-linux-amd64"
      sha256 "e3a69c1572447170d9b0935eb75a2a973147ac5332f812634f33de4f5dc0dce4"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.136.0/aosguard-linux-amd64"
        sha256 "652b84a6569d87d38248803f2bcf40fec4e6913cfdd1c0a4b5fa976782bbe10d"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.136.0/agent-terminal-linux-amd64"
        sha256 "8262687b6e43d19aa1a6dec910ce0456cd22625b04baccb98549f251d47cd4e2"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.136.0/aos-linux-arm64"
      sha256 "8756bbcbffcd82df969414f18572772e59d4208a2b53be0b75499a8fd7eeb9a9"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.136.0/aosguard-linux-arm64"
        sha256 "e586439afc66bce5fb231f750b260b2a67492ac94f250907b20d43589b6d48e5"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.136.0/agent-terminal-linux-arm64"
        sha256 "a1664658134a3fc9fec43f6a0f4ddf852dcb757b28114157b936665f1587b402"
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
