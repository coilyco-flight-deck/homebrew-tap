class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.46.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.46.0/agent-compose-darwin-arm64"
      sha256 "2dabe8935ee2bc59cad3aa68368fe439f156e0572f0a21bab305fd77ec990292"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.46.0/agent-compose-linux-amd64"
      sha256 "90ec64cfc814e1d026102907cafbc9ccca4ce015fc46c41eea19ab311e27c059"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.46.0/agent-compose-linux-arm64"
      sha256 "04260702af9ee72d03e433317c9bcf79f8ca8c8cb6639ae2543bb8ea6e1d3fda"
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
