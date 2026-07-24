class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.25.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.25.0/agent-compose-darwin-arm64"
      sha256 "8f6bdd8d3ebcf362d21f325c8a6153a997c6f302b129d5e5b37eb1ff23803ecd"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.25.0/agent-compose-linux-amd64"
      sha256 "90fed495b7759e0267448eef2874e66f10cc20770bd50e2fff7866e129a6e5f1"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.25.0/agent-compose-linux-arm64"
      sha256 "8cfb0ab3340c5cda45522e102686b64d533a2d997418e4830d66d312c6ed2847"
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
