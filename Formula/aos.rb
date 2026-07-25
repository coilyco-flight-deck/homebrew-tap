class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.77.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.77.0/aos-darwin-arm64"
      sha256 "4956494bef2b42b65dfbcace21304fa1ba1175e59184045dad7cfbedbf21eaa8"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.77.0/aos-linux-amd64"
      sha256 "c0cf79ca4b3663d2d3c49666d16a079b857569d7cc497215a12f421c6737cbce"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.77.0/aos-linux-arm64"
      sha256 "92bfd8cc21fc59000b3d4267740d665a6b598840190ae00dbd8b353f07901d43"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
