class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.37.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.37.0/agent-compose-darwin-arm64"
      sha256 "43a6c592b304ebe8d0e73ae81530f7e277c4868271ce0a1013408293fa0d9688"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.37.0/agent-compose-linux-amd64"
      sha256 "69d2ecbc5c24702ca95a62b9fe048c1a4353aa3b88bf514b2cfbfe08b8dfd833"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.37.0/agent-compose-linux-arm64"
      sha256 "8fee996e474a4a080f3ddf2d8c875ca52000afe5c966b6cb09ca17699a282666"
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
