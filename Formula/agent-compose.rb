class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.35.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.35.0/agent-compose-darwin-arm64"
      sha256 "a036b74366a79296d114afd9fe1b6fea433292c224e6266b395dd7599b5ad654"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.35.0/agent-compose-linux-amd64"
      sha256 "ba497491e11334e3d48f9b47e9fed38ac5aa33f52d11f5b10e2b487d78f7b6c9"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.35.0/agent-compose-linux-arm64"
      sha256 "6989ed5fda69008598c5fcdf3d3d30faadd405a89621bc4b4b7b35af1918ec8f"
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
