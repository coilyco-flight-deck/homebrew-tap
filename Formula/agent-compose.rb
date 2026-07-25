class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.56.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.56.0/agent-compose-darwin-arm64"
      sha256 "60ac47cfd931add0b3e4b5dfe3acec7fb4b513b1582954f7ef708f0176d1bc6c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.56.0/agent-compose-linux-amd64"
      sha256 "9fe5b7efe649e1b8beee95f154caa64035e465f6a6ade8922eaaa864e4f8f24f"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.56.0/agent-compose-linux-arm64"
      sha256 "a4a8d78c1076c990cde644ba6a3e51cb52ebdb8ad3ba0ef81014c7397ba4cbad"
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
