class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.51.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.51.0/agent-compose-darwin-arm64"
      sha256 "cf007f86cac318ed9034fa5a1b7910b768d2d6d2cfac6baf7513ed0bc9137022"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.51.0/agent-compose-linux-amd64"
      sha256 "8929a0d07364312e57bbde2b73a636a88578c8e2feccc12b211a69fc3d955622"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.51.0/agent-compose-linux-arm64"
      sha256 "78d9d09e31e8a6f3c1e5806bbc70e2ec3c8a422fe0e73119d6f2cdfc213bcf6c"
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
