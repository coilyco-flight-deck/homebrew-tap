class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.16.0/agent-compose-darwin-arm64"
      sha256 "22e85672f5d880969ecdbe8853bdb9e7bb565ec8f41e70e8b34e2a61c6a260eb"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.16.0/agent-compose-linux-amd64"
      sha256 "cad9c6223e57a4cbba43404befa4fa9324cf0799e407732c64e7bfa55b571bbb"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.16.0/agent-compose-linux-arm64"
      sha256 "d798470e39a8105b745008215d5aca81e1be988a90f475ef3a7c5c6e093328fe"
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
