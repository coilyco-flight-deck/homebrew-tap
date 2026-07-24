class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.32.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.32.0/aos-darwin-arm64"
      sha256 "9b10e59d935de8607365fb5685a969c1872d81995a6abce3e5aa59faec4110c5"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.32.0/aos-linux-amd64"
      sha256 "024932effaedae1aa8fe75f5b097ae940fd8a5c1ea7081a82e34cd77a7d8efe9"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.32.0/aos-linux-arm64"
      sha256 "d0ab82b5e5d4095f8370cb017d780d3c092cacb3bdd394f73e50139a7407469b"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
