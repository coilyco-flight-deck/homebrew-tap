class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.15.0/agent-compose-darwin-arm64"
      sha256 "3d05c31a8a28d4e115f8750a52308f758875fa759349091865912356a6f51555"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.15.0/agent-compose-linux-amd64"
      sha256 "72d27760b4c1e9112cd1320bac39f1eeaac71055c2284020e4b72d86ebf5ef5b"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.15.0/agent-compose-linux-arm64"
      sha256 "6acd3ab5918c2892ef9fd12350c55f88de98c4a296517b0bc06868e2b2a7d4eb"
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
