class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.74.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.74.0/aos-darwin-arm64"
      sha256 "0d080e7f413a5665ca860dac0656456d1b03ec4bda997de88d965fc272b8667f"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.74.0/aos-linux-amd64"
      sha256 "71e3fe5d2cab4ed8566fda0decb8305dc318d2eac7a67ec37eedbb89dd34e66c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.74.0/aos-linux-arm64"
      sha256 "e3bad10116634bbcaf6b2362ec61da285497f1501c5688518464c6ce660d6cfa"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
