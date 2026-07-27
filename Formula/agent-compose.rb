class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.20.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.20.0/agent-compose-darwin-arm64"
      sha256 "854d69daf53f8cf67d5041e8ee8069691a19f0fc3760d9f769ce746a6f2bab0b"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.20.0/agent-compose-linux-amd64"
      sha256 "57e453d333caf8171b833190c6ae72306657cfa74b2ded39a2d845a1d7911956"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.20.0/agent-compose-linux-arm64"
      sha256 "ef9d146204ca89e8ae809317e8e27c191c45f01badc1dac5644c3bf037694958"
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
