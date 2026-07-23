class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.16.0/agent-compose-darwin-arm64"
      sha256 "f6991b304cb893650911288e09058dc41ad16227f7b3ef042e160ac639bd48f0"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.16.0/agent-compose-linux-amd64"
      sha256 "42a3f89dac28a0a2bad21f71a5dc0f8094d7ce71bdcdc6a1d6864e8ae4a9151a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.16.0/agent-compose-linux-arm64"
      sha256 "23e40f667b72fab58907e8befd26a8985810c96ca2e68dab482d07b132806b6e"
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
