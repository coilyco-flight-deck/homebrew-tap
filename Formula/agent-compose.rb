class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.58.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.58.0/agent-compose-darwin-arm64"
      sha256 "32ee416af5f7a9ab3a5e214e8391d685b628e26314ba78f6045779750c03fb2c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.58.0/agent-compose-linux-amd64"
      sha256 "408eda12e636d0012e8c60f4035933890e301e0369a326c84144ebc10184146a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.58.0/agent-compose-linux-arm64"
      sha256 "0204ea570535a85c5df4ea17fa51d90d0bf9c76d4cafc7d4f33d9896d12d6438"
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
