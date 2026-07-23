class AgentCompose < Formula
  desc "Kai's personality engine for agent context"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.1.2/agent-compose-darwin-arm64"
      sha256 "ba9e02ae46c4ea416153e86228ffda9d9def0d6cd2ec2743709db24d88ed2be2"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.1.2/agent-compose-linux-amd64"
      sha256 "81ea24ffcc6431becbe2cd90042895c19f3e637e48a2d5cd5cec366a4d3c6bd6"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.1.2/agent-compose-linux-arm64"
      sha256 "e20459f1ea98b5ef77585daf2ae9944ba8a6131e894d5ab4e445290a66747a04"
    end
  end

  def install
    bin.install Dir["agent-compose-*"].first => "agent-compose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-compose version")
  end
end
