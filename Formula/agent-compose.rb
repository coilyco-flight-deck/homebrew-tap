class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.43.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.43.0/agent-compose-darwin-arm64"
      sha256 "f3be07b805f8e61c9a42147686813abdc21ba0235be6247c3a816e0032655bdc"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.43.0/agent-compose-linux-amd64"
      sha256 "6cee1952607148a6b2ec5c3afb867db541696738f249996890c14219d2550341"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.43.0/agent-compose-linux-arm64"
      sha256 "95eb3f42360e91fd49bd4ee9c84310ade175c93d06bbdf06da6c89f497106c0b"
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
