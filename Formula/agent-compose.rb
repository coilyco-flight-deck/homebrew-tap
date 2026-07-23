class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.9.0/agent-compose-darwin-arm64"
      sha256 "9107b676bd3bf88456a52b5557e7046ec24049d8055b0326f07b5e33cf156191"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.9.0/agent-compose-linux-amd64"
      sha256 "27d09d480a86e0211cba8d49de48c330e9e99731e95e9cc13aa4eb3683e811fb"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.9.0/agent-compose-linux-arm64"
      sha256 "d345f77ad92d6485205a86f0051eae5a592cbeea3ec5576d2a19a3c139a5b6ed"
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
