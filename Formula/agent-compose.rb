class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.45.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.45.0/agent-compose-darwin-arm64"
      sha256 "469867026ff6b921c3bbf0000144690813c19242ced1cd92ada6ccb8cf8476a5"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.45.0/agent-compose-linux-amd64"
      sha256 "2641d966f98e10698e7d9f02299615d79b664278d798206281407f67d2bdea3c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.45.0/agent-compose-linux-arm64"
      sha256 "6bf4d0c9a702fd338fa174fcd133cc03f52fc1dc86d25329ae5b2c38eb0ce1c8"
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
