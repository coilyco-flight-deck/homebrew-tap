class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.12.0/agent-compose-darwin-arm64"
      sha256 "dca3e1c0e5887e41fcd8951ba61d0812cd3b1fd4bf750863ebffc4a598f49c5f"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.12.0/agent-compose-linux-amd64"
      sha256 "992e34bb0754b4b3ef8d5ab8614a87b2a57dd0c5ba570c6604b341c0f80defd8"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.12.0/agent-compose-linux-arm64"
      sha256 "58b9faf279b2f48595814d8819497627295b50da1c00f8cd3392aad447d9c021"
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
