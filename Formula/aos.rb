class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.71.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.71.0/aos-darwin-arm64"
      sha256 "8c705c00bdbb0cd2aa978337ec1b28319108644bd07472e590ebbd6a273884b2"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.71.0/aos-linux-amd64"
      sha256 "e758d67c7e4d8b81f5329c459e56f846cc0512867580ad9bcd5827412fe08eeb"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.71.0/aos-linux-arm64"
      sha256 "68966bf4e27bcfc58dc648ae2701252da7216653679643430333258d6f7c1dd4"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
