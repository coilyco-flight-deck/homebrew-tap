class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.32.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.32.0/agent-compose-darwin-arm64"
      sha256 "1bbe13e0220c6cbbbb33d0545cac405b7d4a616360e85b588617cc819cc85cd6"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.32.0/agent-compose-linux-amd64"
      sha256 "cf6939c75c5547218ee9342f442b09d70497e5312659580cfc5a00f1353c89ab"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.32.0/agent-compose-linux-arm64"
      sha256 "a10905930c7803e33ad23df74f92c8f9d7b6eb88586a320e4519971a7dc771e4"
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
