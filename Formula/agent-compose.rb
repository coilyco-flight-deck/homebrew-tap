class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.53.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.53.0/agent-compose-darwin-arm64"
      sha256 "4ef35021ea6307647cc673e850d4f8635c296762ed4f9c589bea6b043efdc8f7"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.53.0/agent-compose-linux-amd64"
      sha256 "03321c24fb587f9a5f1f007f6f062de285f542261b3207489af62b2f0d433318"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.53.0/agent-compose-linux-arm64"
      sha256 "21e8cc428eaeee6c6b0eb6236d4978a15e9d2f7909bcf2e9c4117c64e11767f9"
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
