class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.32.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.32.0/agent-compose-darwin-arm64"
      sha256 "ea957c40c594c6ae370fd6c428883a333736961904133bcec7468a4a6a708f6a"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.32.0/agent-compose-linux-amd64"
      sha256 "e1c5fe23fe9aad34693b3158655d7635f29307828e2bc426f7f266c64c29f648"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.32.0/agent-compose-linux-arm64"
      sha256 "6a18cf89d97be86c4925c57c58ed90f3d4c9d2c051a46b1c148b438023d430c9"
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
