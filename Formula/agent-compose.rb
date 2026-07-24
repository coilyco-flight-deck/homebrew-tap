class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.26.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.26.0/agent-compose-darwin-arm64"
      sha256 "9a5710050c16cd7589d6574c9013539f35c87ec057e9860ae21979f7ce24ec72"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.26.0/agent-compose-linux-amd64"
      sha256 "054d000f6b24184164d5d3599372568db83c3be78cb4d3f12cc6fc8c216efa8c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.26.0/agent-compose-linux-arm64"
      sha256 "b47582d15b851c92d87ea9093e074ec728ce6f8a14e72a610fbede4536c70f95"
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
