class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.11.0/agent-compose-darwin-arm64"
      sha256 "17856dc773861775835f89861b2cd79b07164885c2e08e0d15ac8801faa87b0d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.11.0/agent-compose-linux-amd64"
      sha256 "faa58cef0a338e4f32e0f153fda804001f3fd9ada0a5f91c8dac92d0848cd83a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.11.0/agent-compose-linux-arm64"
      sha256 "56c25619ef3bdd94ba3e4d9d4237489b19188daf973b05f129dc5d01360204eb"
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
