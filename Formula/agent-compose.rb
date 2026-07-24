class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.23.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.23.0/agent-compose-darwin-arm64"
      sha256 "6e39bd3ade12e7003e2be2660d2540443195557c86f33a1dd16ba44eb75aeebb"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.23.0/agent-compose-linux-amd64"
      sha256 "33cd568d4d93a3dd89139977c4731b41f5778f2b0fdc975417b76c7dc3809f74"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.23.0/agent-compose-linux-arm64"
      sha256 "0fdaccc47e34f2cf3188ffb0bf2fe323da054208f061fc3d11064e37cb44d1ce"
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
