class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.29.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.29.0/agent-compose-darwin-arm64"
      sha256 "3f8994c6b67bf8b0cab11b3e7ec037fc6706bed8a78a09d5cb9d7c0540fcaa4d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.29.0/agent-compose-linux-amd64"
      sha256 "02ae1e631092b67cd2b9810719817187426a075834d66d079836aff4d0bb1535"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.29.0/agent-compose-linux-arm64"
      sha256 "66c8df2a93b96529aaeebde764b92a22dbb7878f547ed90737b453633a9ff649"
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
