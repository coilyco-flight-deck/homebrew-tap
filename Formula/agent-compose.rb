class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.36.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.36.0/agent-compose-darwin-arm64"
      sha256 "249768b2f3712603cfdeed937d8b60148f6a737aff9052c391926cf630cff69c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.36.0/agent-compose-linux-amd64"
      sha256 "e431baf3f547e08a31d9ad6ef45032bbe7e48e1ec551f9138f55c8ec3da49f00"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.36.0/agent-compose-linux-arm64"
      sha256 "22420a0bdb48e081ce647abfc12a110657f740dfebd143cc9c458cd744c191a0"
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
