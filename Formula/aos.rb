class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.138.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.138.0/aos-darwin-arm64"
      sha256 "7811284d3d3c3a93eb2ceda23dcd3d523b89609e586accbd5de68979ab915304"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.138.0/aosguard-darwin-arm64"
        sha256 "88da6a01281dd3c917501cc114d7583158ace0af9403a416e654f3b9e908ee86"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.138.0/agent-terminal-darwin-arm64"
        sha256 "954daabb0e321d3fad8c118db3943852c4d3c87e2409d891e9711ac1b3ecc121"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.138.0/aos-linux-amd64"
      sha256 "61901817c75da7e2c4ecb7f80114bdd332607105741c2b7a1792e7e86dffa362"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.138.0/aosguard-linux-amd64"
        sha256 "341fd31854342660f1b884d86ae48f556cb2e146e4eb2bc3be3563e68b034a65"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.138.0/agent-terminal-linux-amd64"
        sha256 "de78c2aacad75bbc8cbca3d2637ee4acdc6f440ba1af8d51f2168fb2f02994c4"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.138.0/aos-linux-arm64"
      sha256 "6fdfcb8f9c59474663155c466352555176260c3c405117f9a3ddce59a6dab2f1"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.138.0/aosguard-linux-arm64"
        sha256 "f780d46f335aadaa93415c9616c833a351780378d57ea60101c4870e62430bc2"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.138.0/agent-terminal-linux-arm64"
        sha256 "11d0a8c4c0467432e95dd594d3df366c16ef7b5eead58e9ee7262474771016c6"
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
