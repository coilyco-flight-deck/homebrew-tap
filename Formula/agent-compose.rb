class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.30.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.30.0/agent-compose-darwin-arm64"
      sha256 "15a0417d776036608b4ad827badf131ad1a03f96415cfa05d05f5c27553ad3b7"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.30.0/agent-compose-linux-amd64"
      sha256 "666ed676cb8037cc457103da2141f2bc1d922c17fe41fed47e7f7035852f3d0b"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.30.0/agent-compose-linux-arm64"
      sha256 "2110fbcb96cc74f6b15656514dbe89e0513cc71915282c7e46ab1afc57877385"
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
