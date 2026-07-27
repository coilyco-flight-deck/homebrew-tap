class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.25.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.25.0/agent-compose-darwin-arm64"
      sha256 "32bff7a2ac0a0e496cf2491a3361292893b752457be66e28e339a57a7b240eaa"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.25.0/agent-compose-linux-amd64"
      sha256 "8cc486804f0f48f83399cad1f3b0ce9fcab7192483d44b946525b1a0027cb9bf"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.25.0/agent-compose-linux-arm64"
      sha256 "167224bb41271f7a01bb11633c52978beecca11e874d3542bf51fa5c7d3ccf19"
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
