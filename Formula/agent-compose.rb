class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.22.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.22.0/agent-compose-darwin-arm64"
      sha256 "39c5a0170deb9b15ff372928ef77f9b9e542c236a76c81d73b9628d6da15e382"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.22.0/agent-compose-linux-amd64"
      sha256 "00926e9e4b454c452f3c46aa062d8e0aca3da95d5cc373df831b5218a2a1a9ba"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.22.0/agent-compose-linux-arm64"
      sha256 "0d7201c696b94da4d3599bfef6fbc75b888fd45a8efcb259bc3e74df68dac256"
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
