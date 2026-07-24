class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.47.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.47.0/agent-compose-darwin-arm64"
      sha256 "2ead67bc04621f7ebe8de8c6d81962727d2d0b4d0a9c29e84335ebd388935ef2"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.47.0/agent-compose-linux-amd64"
      sha256 "0aac05564034e8284ca9a6dacbcf4f1400fcd51824456dae2c4815e72667e960"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.47.0/agent-compose-linux-arm64"
      sha256 "38c6638c7b0959ec60d01242a0c5579fa8443405539cab74d3ec87ffc1dd544d"
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
