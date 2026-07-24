class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.27.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.27.0/agent-compose-darwin-arm64"
      sha256 "62dc013cc9b10534058da25bf54b42f881607e9eb2a06499fd41df842a190ad5"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.27.0/agent-compose-linux-amd64"
      sha256 "27d32a9b436fedd27e1626e10c0a178c91099f30231c3c39d6cfa75dfe624b0a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.27.0/agent-compose-linux-arm64"
      sha256 "54f6d31c7b10fb0968026d025e5e888840ef5a9d0c8779992d4a8776057239c7"
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
