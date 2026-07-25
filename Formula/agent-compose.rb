class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.48.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.48.0/agent-compose-darwin-arm64"
      sha256 "04c87ecaae7c375d9fd688b90ddc691ae76922932442317cb02471d6244e4c88"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.48.0/agent-compose-linux-amd64"
      sha256 "4e86b2949d48690db6c7fa64b4c541078e142bdc40f4f3510ad8e772e14ad456"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.48.0/agent-compose-linux-arm64"
      sha256 "15f4ca101dc23073756b02be022188bf6efa123710a15678cde846d3e92c9f0a"
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
