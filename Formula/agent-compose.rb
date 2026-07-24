class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.28.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.28.0/agent-compose-darwin-arm64"
      sha256 "822c74802e7ba3633368e29b305fe17273a093d3309418889d32b6fc5376eb74"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.28.0/agent-compose-linux-amd64"
      sha256 "5edda3a833b02d3a0ca4e5904e80689f8c534a33e2554c426589399e37ff19a6"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.28.0/agent-compose-linux-arm64"
      sha256 "b559862e6d4c35b51536aea87c35654db60b19810cf68bf8bb99300ee99b230e"
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
