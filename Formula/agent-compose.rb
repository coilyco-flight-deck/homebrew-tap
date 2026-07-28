class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.27.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.27.0/agent-compose-darwin-arm64"
      sha256 "3cccf6b84b529da64a9496135e5ec9b6de423ea3712ef19baa798a8f806f1efb"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.27.0/agent-compose-linux-amd64"
      sha256 "5f6064d661f783018755d1cfb85cf9c320094ba99d5857a32d6cec90cf10f308"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.27.0/agent-compose-linux-arm64"
      sha256 "f821e45ae8516f0ed731a9a5e3b146a54c24e57234c21f430f80d4410f41831b"
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
