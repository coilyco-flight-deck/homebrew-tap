class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.46.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.46.0/agent-compose-darwin-arm64"
      sha256 "f763cd26f3f8b3cb33c0b9944e275c76e848a0111e464c9fd7352afbef083d43"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.46.0/agent-compose-linux-amd64"
      sha256 "94782baee568a79d5001bcd876d21c3e4bc2c4f7ee1d2c6eadf88363b664dabd"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.46.0/agent-compose-linux-arm64"
      sha256 "32ca4e1f24eb04f97634570b7dfef075f3023e4d3ef022b0c1b528a54c288bdf"
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
