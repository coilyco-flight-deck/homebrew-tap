class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.59.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.59.0/agent-compose-darwin-arm64"
      sha256 "046160156527727f981abb96f00e294ad087bf98898fa66464c3700b6ff72e21"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.59.0/agent-compose-linux-amd64"
      sha256 "b9ea722789ec734ab3f98d8c00c4d3d081015efd817dda5a2e6a8faa02383202"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.59.0/agent-compose-linux-arm64"
      sha256 "7478617b308394269b54b4cc2d0f10d7076aa6a128f68103f9dd3a680a0b0975"
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
