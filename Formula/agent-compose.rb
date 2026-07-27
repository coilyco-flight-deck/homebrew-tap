class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.24.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.24.0/agent-compose-darwin-arm64"
      sha256 "28a6b5aff79b0bb9e6befe1aa077cc82135d1df7222bb072721601664d085ce4"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.24.0/agent-compose-linux-amd64"
      sha256 "73084c6527a22dfad8fc66de173b88c2cc0d9cdb1e45a8b24b9e7b5bf7244be0"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.24.0/agent-compose-linux-arm64"
      sha256 "4eb3bd3ac1d3b8db94c71b1f647a7f1930c78056817677f45fa0223d24a54ca3"
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
