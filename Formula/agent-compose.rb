class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.29.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.29.0/agent-compose-darwin-arm64"
      sha256 "b62bfca91fa183781989de252edef2d2d2e308f021c05692a664a2613ff1d507"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.29.0/agent-compose-linux-amd64"
      sha256 "34d76dcb9f785bae6e8e287616ef5a8c39e5429e2286ff236371312507d351b9"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.29.0/agent-compose-linux-arm64"
      sha256 "f4c0c08bb171585161bbb03ba55e30b826ff3671062e7bbbf9404b7142908679"
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
