class AgentCompose < Formula
  desc "Kai's personality engine for agent context"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.3.0/agent-compose-darwin-arm64"
      sha256 "dc0c2002c22132f7a022e985ae36bea98a8d5c25fab10018a20d9ae05db23947"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.3.0/agent-compose-linux-amd64"
      sha256 "ec9abb49f19e1904f93a1a1c8fb3488bbc5b710bf0ddc7a01d119564ebd6c194"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.3.0/agent-compose-linux-arm64"
      sha256 "a4bee6fe9c90af8eeb35360271a00d58629402c3de7938fa0069f4b9d5a607e5"
    end
  end

  def install
    bin.install Dir["agent-compose-*"].first => "agent-compose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-compose version")
  end
end
