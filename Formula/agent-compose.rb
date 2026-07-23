class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.6.0/agent-compose-darwin-arm64"
      sha256 "794e61b4501ae1825c303d69880446e2e1034babb8e545c7299b560afa97822c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.6.0/agent-compose-linux-amd64"
      sha256 "bd9cccd1afacd28e13c28867351600455ab5339c36dda97a5f6a3e4a1ebe5f8e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.6.0/agent-compose-linux-arm64"
      sha256 "ad4716387734fc2a56b59c21f686191d0e4d403c0b0d4d15892bc835ba3e0ad1"
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
