class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.34.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.34.0/aos-darwin-arm64"
      sha256 "39fd7921f21f00abbcbe4fbd3d517d6fa78f583733eb5c3fb802a9a80b200626"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.34.0/aos-linux-amd64"
      sha256 "081571a1699bcbc65cf71cd813d6bc64fd50acf079a052e077696c9da3a27b79"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.34.0/aos-linux-arm64"
      sha256 "ff0c7bc73e3c5e361c8ea781c0822a60e10a8dbeaec7f7c4ed1eec548a410dc3"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
