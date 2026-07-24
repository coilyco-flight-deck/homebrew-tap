class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.66.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.66.0/aos-darwin-arm64"
      sha256 "f5de2fbf5e4b5bbd25c764ffac617bbb77a7c07bba579d5e9f1a43f618e82167"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.66.0/aos-linux-amd64"
      sha256 "876ee9a1b37e92812a464208c8d8f2049879b8b03099ddfb8839de466d7a5ccf"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.66.0/aos-linux-arm64"
      sha256 "7185baa385ed2be5a224180c95aec4b026f3ae86fcd8191b2d7479437fad60e2"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
