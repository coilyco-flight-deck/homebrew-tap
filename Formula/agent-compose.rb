class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.66.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.66.0/agent-compose-darwin-arm64"
      sha256 "77c143fc77df4d8c4b9f011823ec0fdd2a00aba22f3138dd98591a9e3a7155bd"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.66.0/agent-compose-linux-amd64"
      sha256 "e4ee1e5140ccdfe20377f66af4873cb62efeed0a39f42f1c967a7bbd85ba101f"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.66.0/agent-compose-linux-arm64"
      sha256 "eadab75589b216a0d7f4bd8c8c09ba919a03adbb706e57c19fa27027975bf558"
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
