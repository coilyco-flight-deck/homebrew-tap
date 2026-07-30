class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.47.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.47.0/agent-compose-darwin-arm64"
      sha256 "8e0f8ceeba450cf1105bf2096e779ea188f9e9c22eedca06a48b2319987a3afd"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.47.0/agent-compose-linux-amd64"
      sha256 "55b2d7b9204a30754d30d1073a0ed928f984bc48dcd6c2c645b82172da9a8b6a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.47.0/agent-compose-linux-arm64"
      sha256 "108ebd61f79e82ff341b583e83e4c293c77af5a2d58c981b9578d51b0d913ce3"
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
