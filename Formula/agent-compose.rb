class AgentCompose < Formula
  desc "Kai's personality engine for agent context"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.2.0/agent-compose-darwin-arm64"
      sha256 "3bbaf7d200c269169ea0aad33b44d7381cfef2ab567aa624e94287e85a98de52"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.2.0/agent-compose-linux-amd64"
      sha256 "26f86c2d42f4251cb8da4e2888a64a49cefe687dc6309e6bc1277021aa8581f1"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.2.0/agent-compose-linux-arm64"
      sha256 "2c08b9563b22906bc271494b0d5822383657cbfa9745ef17176a4d99347ceae6"
    end
  end

  def install
    bin.install Dir["agent-compose-*"].first => "agent-compose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-compose version")
  end
end
