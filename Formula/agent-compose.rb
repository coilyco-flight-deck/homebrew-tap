class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.37.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.37.0/agent-compose-darwin-arm64"
      sha256 "ff804ad4ab91fae706221feda1540d50a52f7512759125ec986c551858a31523"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.37.0/agent-compose-linux-amd64"
      sha256 "9397132d015d78daf8f7892035ac67659e7b4bd2fd468eb6e83d35e4615c47d6"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.37.0/agent-compose-linux-arm64"
      sha256 "66523a9550459ae5b56793404c576d7fc69bbc24c96ef5b64ef33ebe3bc6ed7c"
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
