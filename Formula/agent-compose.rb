class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.55.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.55.0/agent-compose-darwin-arm64"
      sha256 "3ce4a23fc17cc68164332b037198459d8b5bb0fd64e05faee13e8f05742d2615"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.55.0/agent-compose-linux-amd64"
      sha256 "ec9ceab350b94319ab820224b2dd0c1cd189c34b0a873bf96c462a4a6c1100f0"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.55.0/agent-compose-linux-arm64"
      sha256 "9e061285a94332a100bfd4be326840f4c74459be19038971f244436f25bf545f"
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
