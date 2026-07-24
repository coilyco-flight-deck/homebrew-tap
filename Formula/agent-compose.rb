class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.40.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.40.0/agent-compose-darwin-arm64"
      sha256 "0861d8adf51d8314667fabd67752ed358471888b2bf4f6de5f358033e46fef5f"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.40.0/agent-compose-linux-amd64"
      sha256 "bb8b416cc1971d492fda48f510f9777bf1aa557e048c2b1f99739228baa59170"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.40.0/agent-compose-linux-arm64"
      sha256 "782c98402dd15b22042bbca5e2ca94ee7d18f2895436013d38c5dcf1b20909d8"
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
