class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.61.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.61.0/agent-compose-darwin-arm64"
      sha256 "d69f2e8f2c53f2a0ad33236e4510dcda90aa11d9ad7b98dcb03cf65e62facbfb"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.61.0/agent-compose-linux-amd64"
      sha256 "140e63c236e65667d6f4dff9730edaf964cb686599e826d0fb749b67d59760d1"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.61.0/agent-compose-linux-arm64"
      sha256 "5b4eefb5c1b2765e99a76d36b3cbd2c9e6bd3fc25cdf8d1c8aad418a41fd4b5c"
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
