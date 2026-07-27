class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.11.0/agent-compose-darwin-arm64"
      sha256 "b45b6fe0c63a6bf657db5a9c5f62071ec3e102922f2514f7f24442ee9cb3119d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.11.0/agent-compose-linux-amd64"
      sha256 "02aa4d0f3161771a5e247d3f277e56a1313ec4f340ed652322d52df28bb9e454"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.11.0/agent-compose-linux-arm64"
      sha256 "83048231b71a43133f43ed0957f34665049f43243dfa898f5a04005065deab27"
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
