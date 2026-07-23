class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.8.0/aos-darwin-arm64"
      sha256 "473ddd77c587961468cdfebf805455b75d4b81c2041082c00bcf8b5f44f95dee"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.8.0/aos-linux-amd64"
      sha256 "2f8b2d72c0a9e6874609c5f0e092a8e12de3cbb967677e7c8b3bbf95a7541214"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.8.0/aos-linux-arm64"
      sha256 "c12c84551bb2fa4a43c40e98464a7297a1acc22945f5505c70c96633df8cb31f"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
