class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.133.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.133.0/aos-darwin-arm64"
      sha256 "369de071aabacd12095434dfee8778cb152f51ec335e6106f214b1bdbca333dd"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.133.0/aosguard-darwin-arm64"
        sha256 "fedba5e22706f647b583f5fc305364d3313d83e1ad135402a5a8f52caff74ee7"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.133.0/agent-terminal-darwin-arm64"
        sha256 "fa66589cd906a1e9cf426c04918550fc28af1a4fe6ede8f135bb4e7fe38b15ac"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.133.0/aos-linux-amd64"
      sha256 "c53481c1b3d5d1c343612c42fc1a2863e9146354219762e25fd046a99bd99665"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.133.0/aosguard-linux-amd64"
        sha256 "8c1665aea51ddce74fe9f2d150ffef60bd4523339ff96d9a957689aeeb148ef1"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.133.0/agent-terminal-linux-amd64"
        sha256 "0f5d8c28055ef2195eb1b8c3c996d27eb1b9f7011ba42192c1ae36f985c721d0"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.133.0/aos-linux-arm64"
      sha256 "fad54938b81e7d75aca0b404c2f48ca74b312d9ac8e13687c414e93c6835f729"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.133.0/aosguard-linux-arm64"
        sha256 "8c0b13d9b590b78adacccb7681200a1fc975e32ca6a8d80710e8c8a17bebb2d6"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.133.0/agent-terminal-linux-arm64"
        sha256 "85476d42168a777835263276f33ba2d4e32ca0482f46017545c3befc882dd437"
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
