class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.48.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.48.0/aos-darwin-arm64"
      sha256 "17ad0c1448129732a65ad36b16838f72c887515405c854f4911d3ca2e29a121c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.48.0/aos-linux-amd64"
      sha256 "952f3dd31fdcc7a298120fdf482c50f2920fdfe414dc881dcd766328b2241209"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.48.0/aos-linux-arm64"
      sha256 "c9a1f744e734bb43a97c508dc6c22b5f838ea9636c9e682a3e62bb9fbb1f17c2"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
