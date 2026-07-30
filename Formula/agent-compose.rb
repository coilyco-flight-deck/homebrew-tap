class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.45.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.45.0/agent-compose-darwin-arm64"
      sha256 "6fb0239bb0d2c64416ac220e5d87ee148a76adfb277c94ae5f5cc633d6186ba6"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.45.0/agent-compose-linux-amd64"
      sha256 "c4e79773949bdae5a34b66fc0a91728c2833939c5174af03ed5cff904396786f"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.45.0/agent-compose-linux-arm64"
      sha256 "1a6a1ad854d15b60e68573eee7d6db15b9585952476e3abd23f9ddb1290a2373"
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
