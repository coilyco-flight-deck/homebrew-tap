class AgentCompose < Formula
  desc "Kai's personality engine for agent context"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.2.1/agent-compose-darwin-arm64"
      sha256 "9ea99bf842cac02c1b78b574b8eccf1c1774e5bcf3ca9dcb8939b79d3db78e77"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.2.1/agent-compose-linux-amd64"
      sha256 "48c320ecd26fb56bc3dc84c129e990286864424e8f478245e5bf30cf85bc41df"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.2.1/agent-compose-linux-arm64"
      sha256 "956eb4a2818f8d6fc67cf2e6247d6777c5dbf123f1fd8cd92ac6801e8821fe1e"
    end
  end

  def install
    bin.install Dir["agent-compose-*"].first => "agent-compose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-compose version")
  end
end
