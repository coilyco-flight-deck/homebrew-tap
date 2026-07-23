class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.17.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.17.0/aos-darwin-arm64"
      sha256 "02878b2909f843fa41c6c4e7d90a3294f2f33cee0c1f09088f2a2f3e0001ad50"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.17.0/aos-linux-amd64"
      sha256 "2f621f25d077f3d0fe8ab99cc103db5605e7f7d275df3fb63cdb108ad6619de2"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.17.0/aos-linux-arm64"
      sha256 "bf8ad01729d9ace4d1a8effafe6305443785f25f964fc1221be90224c7d2bda1"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
