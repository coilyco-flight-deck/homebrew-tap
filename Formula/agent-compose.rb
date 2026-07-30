class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.48.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.48.0/agent-compose-darwin-arm64"
      sha256 "7ed71326ff23070e2224c8b04557c5e4c310ee7ce8b9cd82b836c2ec3fc1e4d3"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.48.0/agent-compose-linux-amd64"
      sha256 "7e3b9e7452ae0a176f8eacc938cb4e0fd98a76afcbbe033af60507ac65f9b39d"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.48.0/agent-compose-linux-arm64"
      sha256 "ac017dcc8a9dee8724ab68f1b18fb48873e30cc93bd1b0d3f88a7ddcff667262"
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
