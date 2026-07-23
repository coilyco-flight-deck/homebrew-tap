class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.14.0/aos-darwin-arm64"
      sha256 "1588c981f8652d0bb2569e2ca81475ef9e5ec512ad5c23dce30b3314a1b07a1b"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.14.0/aos-linux-amd64"
      sha256 "85dc30595448d6ac73c619496cf6426d9831c5a8398df59c9c1c65aecda8af9c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.14.0/aos-linux-arm64"
      sha256 "75b7f07be4d57d057a0b123c20bff050fe952378bfe6ee9dd4bef1cdc43658ef"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
