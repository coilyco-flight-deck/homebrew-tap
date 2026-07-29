class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.132.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.132.0/aos-darwin-arm64"
      sha256 "53db1c6770e06c217f1816b1a03636a5c77b50baaf80f1f252f845faf8f9f8e5"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.132.0/aosguard-darwin-arm64"
        sha256 "37e28c59433478ee8222efb09e57db17f96e5e9501e0323b6e542e411687d3ae"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.132.0/agent-terminal-darwin-arm64"
        sha256 "789ae993a5cc5e35a0ad98186b3f12cb7cdf0f07eb46b57bd4814b30f5fd2caa"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.132.0/aos-linux-amd64"
      sha256 "0749c0dd607dcfda904347b833b732ebf2d4b35f2b9169fbe687c2be9fec7c54"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.132.0/aosguard-linux-amd64"
        sha256 "0402e20f23de95408a2b4316866a0390c49cc503230aa0593de6f9ce0c0f0acb"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.132.0/agent-terminal-linux-amd64"
        sha256 "51c4e7a6bb20fb875646477734471fae3bd8599040102be75b43e9ee2ede2daa"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.132.0/aos-linux-arm64"
      sha256 "996c4f268264b68a5d12c6f4908255faa4ba48148df48446af058e2c9bed8662"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.132.0/aosguard-linux-arm64"
        sha256 "3b7189a90c19f3ead22aa6ed65cbe28616a07f8dd19153994a391d55d5aa1b84"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.132.0/agent-terminal-linux-arm64"
        sha256 "4a4fb5794f02a94bc7183c7e826a362fc69066b2c84ebdffff86de785c57e763"
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
