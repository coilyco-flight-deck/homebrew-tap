class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.6.0/agent-compose-darwin-arm64"
      sha256 "02379ff495de46251d166149105b76ae9524d17b17194e8161ac8c1592743b90"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.6.0/agent-compose-linux-amd64"
      sha256 "8f979352db601d62fc1317814e509d04b7700d2d827f58bcf3d7a0475c79808f"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.6.0/agent-compose-linux-arm64"
      sha256 "9a2a6269000c89590e854520329dfdac23799396a03c10f47bb3fe13399ea7e9"
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
