class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.17.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.17.0/agent-compose-darwin-arm64"
      sha256 "6b9c4e2506c02c7237aa156f0fcdbb5d4512c79e17ce401420d95552ac9ab320"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.17.0/agent-compose-linux-amd64"
      sha256 "44f5aa200462c01681526f95d9ba261630ac69279c695bd35cbbe5442b41b906"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.17.0/agent-compose-linux-arm64"
      sha256 "e8b5869c9ab55cbfd44001b8fb4dea9dad1deecb10e7890457e4401757a13696"
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
