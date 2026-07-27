class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.63.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.63.0/agent-compose-darwin-arm64"
      sha256 "06821c92cc0e9b7cab147ea3bdf7e569ea26f8bf9ce7a3fc911036f4fb7f21e7"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.63.0/agent-compose-linux-amd64"
      sha256 "0fc23481cd14f06c2494bccc4ad0cb48c0c52c06eaf2d256b1e8939089f31a4e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.63.0/agent-compose-linux-arm64"
      sha256 "8c4a1190e768e40a2859023f663c9ee992ed8078b9cfc4cc5b3fc5d6a3b97fe0"
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
