class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.38.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.38.0/agent-compose-darwin-arm64"
      sha256 "5b8dca340a35804baddfa24cdcc50e7af34b2ac38b8a43c567126ddc0fdb7eb4"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.38.0/agent-compose-linux-amd64"
      sha256 "e627ec6d60b71796cf3af9ecd3064618f17bc36a21e49d9dbaca8b108d2fc4d2"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.38.0/agent-compose-linux-arm64"
      sha256 "7bc853b2de87711ae5241b0aec91c56242cacbaffb252409d5f0f97a223e93b5"
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
