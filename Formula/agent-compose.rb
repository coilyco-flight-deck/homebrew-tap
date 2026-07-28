class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.31.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.31.0/agent-compose-darwin-arm64"
      sha256 "eaf9b0090173649e09837268dfed2ad65fc1825893a03ca3b9be2f778483938a"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.31.0/agent-compose-linux-amd64"
      sha256 "d6f01c9bab32cb61e925c7b00d7d97fbf166c3b109fd1c254d0a14bae53432f8"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.31.0/agent-compose-linux-arm64"
      sha256 "90fada4a2b57239f17121ef179ab0d1ec7668a4ef0d8030eeecaa197289d9e34"
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
