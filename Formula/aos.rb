class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.12.0/aos-darwin-arm64"
      sha256 "a9f9e3aa3c178267550b0e993ca15e7299f810caf452b4ab8d6e120720935b24"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.12.0/aos-linux-amd64"
      sha256 "7f47f47808bbac23385fb1b44eaf1f2535609e34057235380871c210ac70bf7b"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.12.0/aos-linux-arm64"
      sha256 "b0eaed05ef2d712587a0bb7e8a8ec1c1f1dc6ea1f45b930255d0f243f36b3432"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
