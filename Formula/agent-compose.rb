class AgentCompose < Formula
  desc "Kai's personality engine for agent context"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.4.1/agent-compose-darwin-arm64"
      sha256 "c35c453ba6c5051b4f917bce296297b77b141f2390cf3d8933509d8ac08ee2f4"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.4.1/agent-compose-linux-amd64"
      sha256 "78bcda7c814186b808a688671eff9bea45fae4ba040dfdb6deeea9d3914bbe45"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.4.1/agent-compose-linux-arm64"
      sha256 "0d210895c03c05704b1bc27d7cf148f783967830809d5bd12988f885ddb45590"
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
