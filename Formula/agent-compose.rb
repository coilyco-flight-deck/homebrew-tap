class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.52.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.52.0/agent-compose-darwin-arm64"
      sha256 "ec80fb6a86650383930d542dc4cac90a69fb0811f1069ea592475ffe50cce4b0"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.52.0/agent-compose-linux-amd64"
      sha256 "bd5ae8cea9903152b0a660763935dbe259bed9c4138e1ba7f2d2d25dfc6bd71c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.52.0/agent-compose-linux-arm64"
      sha256 "394501f47f1a1dd2fc2e1babfd8b1c841ed9f7c26d1f62e20e393a7da44036ae"
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
