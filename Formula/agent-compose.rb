class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.41.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.41.0/agent-compose-darwin-arm64"
      sha256 "0778eb826a8f02bd855e1412df2681497e841db65fd100da243c8589247ce456"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.41.0/agent-compose-linux-amd64"
      sha256 "a4d2fc046c22bc675c6cb996a85c945bd48ec9959d3551182e567101e5157a82"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.41.0/agent-compose-linux-arm64"
      sha256 "7cdd08cdc888462a3be357a4686977c74ff41291ee65ded6c72aabfc5732c866"
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
