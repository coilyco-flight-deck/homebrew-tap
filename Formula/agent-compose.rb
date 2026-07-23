class AgentCompose < Formula
  desc "Kai's personality engine for agent context"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.4.0/agent-compose-darwin-arm64"
      sha256 "d478b3d2bc88b3297a1b8282456e549485f2eae7e7478bb60bbe80dbc3ded104"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.4.0/agent-compose-linux-amd64"
      sha256 "443ddbfa3a57d15c74f88e8493e1fbbd80d6f5bbd55890e29451d1219a35faaf"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.4.0/agent-compose-linux-arm64"
      sha256 "ab80f9690c53dd5214a5ab9cbfcb7f159ed878917dd77eb0a44afe648d93e897"
    end
  end

  def install
    bin.install Dir["agent-compose-*"].first => "agent-compose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-compose version")
  end
end
