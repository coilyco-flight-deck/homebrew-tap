class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.21.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.21.0/agent-compose-darwin-arm64"
      sha256 "10773f40a3d47c8ba1471734cd4cd93d1c3e75d1db52605a34ec11efaed37751"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.21.0/agent-compose-linux-amd64"
      sha256 "5ccff335a80e480b15facdd164196aa2d66893bddbeb36e8ae1ccc187908cb53"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.21.0/agent-compose-linux-arm64"
      sha256 "4cf4975f095d7d1fe8bf2def54fbc1183cb7613868a9fba76fb0ba5b87965711"
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
