class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.30.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.30.0/aos-darwin-arm64"
      sha256 "5b7b061092d3423f69aa1343e4cd6121f32866e21ebbecfdfc9310aaf1a4a2a2"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.30.0/aos-linux-amd64"
      sha256 "95d0c245169224ee6a1b8669794e53bb98ee42c0a8f7560665015225c3c73fd0"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.30.0/aos-linux-arm64"
      sha256 "5186c68487ee8bbdd98aa20a10b48308d2b34d8cc166485ae728d966aae87b48"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
