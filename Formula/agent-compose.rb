class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.43.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.43.0/agent-compose-darwin-arm64"
      sha256 "84c94e8f84d478c04fa3c3c988bd2c5c1b761431108033176551abaa1033aa31"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.43.0/agent-compose-linux-amd64"
      sha256 "b2ee152e58d0d3dfebbfc57c15bacd23c2c33e2bf198c5a43a6f2727cd0dd5c8"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.43.0/agent-compose-linux-arm64"
      sha256 "a40497fb01eaa5980f09f96b7f5b32d1c8b85313b3a9cfe98f31d53fd3ea8386"
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
