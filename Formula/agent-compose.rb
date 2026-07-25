class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.50.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.50.0/agent-compose-darwin-arm64"
      sha256 "b67dd2fe30f369e5dc1e54fb75d436bbdc0526de1022bdbd9fcaacbd0f120a8a"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.50.0/agent-compose-linux-amd64"
      sha256 "dcbecc5df074c37773ec8ba3510ea88a388dc42b0e9edf9543321c4ef7385708"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.50.0/agent-compose-linux-arm64"
      sha256 "2b20397da29bc3d92d4cec628af502675b6ee3ca454700eb419d2da918f3223f"
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
