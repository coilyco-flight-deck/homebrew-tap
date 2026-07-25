class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.78.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.78.0/aos-darwin-arm64"
      sha256 "d0d06c4b904577348e639684722c439e3e7ab846d821097577f9f18309042b4d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.78.0/aos-linux-amd64"
      sha256 "bb0ac650355efcc9f2e575fe9f2d41c7ad84d5bc3e95f689d6818093d60c0846"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.78.0/aos-linux-arm64"
      sha256 "f28459a48e7631e9892852e7985443db4821d0a8479d49406629ff0c7b00480d"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
