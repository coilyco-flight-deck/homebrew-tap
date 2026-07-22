class AgentCompose < Formula
  desc "Kai's personality engine for agent context"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.1.1/agent-compose-darwin-arm64"
      sha256 "4c2593b5e612e60cf20c13e911132f3e87570d14e08243a33a63fe9733bf104c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.1.1/agent-compose-linux-amd64"
      sha256 "22ae5cdc906cdd99d3c7f14ded2c9325bfee81667d9943915cb3052d988e888b"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.1.1/agent-compose-linux-arm64"
      sha256 "24ae3c6bf59aadc09c97165820b088ede2571689f6449ef3f718a3856baa64cc"
    end
  end

  def install
    bin.install Dir["agent-compose-*"].first => "agent-compose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-compose version")
  end
end
