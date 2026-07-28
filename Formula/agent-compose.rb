class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.26.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.26.0/agent-compose-darwin-arm64"
      sha256 "835db14d9194a9355c369c39fca0011910122188d6f6175be1533e73f28bbd16"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.26.0/agent-compose-linux-amd64"
      sha256 "3f4d9843e85c4d1c31e775b38e6facafeaccd89c6554f385f6ffca3a4f1eb63e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.26.0/agent-compose-linux-arm64"
      sha256 "b0eaac46350f7ea29a199358fed0661b2af4041f2adaefcc7d88a89bbeaabe6d"
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
