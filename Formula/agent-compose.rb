class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.70.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.70.0/agent-compose-darwin-arm64"
      sha256 "88262bbaa8ff79afe092dcd421fa4c5ceb065b4fa3a34a74d3f6dc01b150ad9c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.70.0/agent-compose-linux-amd64"
      sha256 "165de4955e84c9b42d2177c61b8f5843871038385694eb10a511d5ceecdbfcbd"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.70.0/agent-compose-linux-arm64"
      sha256 "ca83ee04e5e6b91cb03db124c4486aa167fb4b52e32c2e2cfc729294089e5bc0"
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
