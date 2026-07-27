class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.7.0/agent-compose-darwin-arm64"
      sha256 "beb2cf21c0b9f2ec6e6be1b24f3c13f343f20512b6236ff1a8a28cb4a93e186f"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.7.0/agent-compose-linux-amd64"
      sha256 "67f6199e0ecfba33a56d2adb6b38e978e23a6c85094e869e61df9dd7d35331e2"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.7.0/agent-compose-linux-arm64"
      sha256 "be9e756ce5ce392dd2d6b84a7d41ca8bd8657bbaff511d8a0c5db9c3fd072ff6"
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
