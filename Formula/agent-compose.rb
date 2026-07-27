class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.22.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.22.0/agent-compose-darwin-arm64"
      sha256 "38c304525d96a9798c2be66ccddf5a09c6024862449e152764cfaa7b4299f000"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.22.0/agent-compose-linux-amd64"
      sha256 "0b4bf67e1198b9b3e7117513a39a4849e736cd88cf531d7865ae663b8990b72f"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.22.0/agent-compose-linux-arm64"
      sha256 "71880b6a6a11213d313d122a5f23c24e15c5bf2304f1883a4e7f3c1766af0426"
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
