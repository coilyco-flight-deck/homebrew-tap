class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.60.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.60.0/agent-compose-darwin-arm64"
      sha256 "8eec5e9964a42471ac696bc341cc4eceeeac17ba049f5d06701b90b1403c2723"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.60.0/agent-compose-linux-amd64"
      sha256 "79b6dbcd69135c0b4dbd63867c37fc2fb503338f967b1e9dd3bd073ffa98611d"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.60.0/agent-compose-linux-arm64"
      sha256 "4a1121890546b96f2074802f6cc57577c545d48f66628ec2adb7b21c56ada349"
    end
  end

  def install
    bin.install Dir["agent-compose-*"].first => "agent-compose"
    bin.install_symlink "agent-compose" => "acompose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-compose version")
  end
end
