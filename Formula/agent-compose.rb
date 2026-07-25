class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.57.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.57.0/agent-compose-darwin-arm64"
      sha256 "601db8125b28e7ed332ecdcea2381f00cbd2c99cf93a204e83ead75f7fadae62"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.57.0/agent-compose-linux-amd64"
      sha256 "3d28faba13c9e959be4e528700921329f147a583f51b9cd25638b170720714ef"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.57.0/agent-compose-linux-arm64"
      sha256 "9b9c178545107429a9b2349d0a7598ec9546786cd585ad43c2dd65fa7a78ad0a"
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
