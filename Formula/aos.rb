class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.25.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.25.0/aos-darwin-arm64"
      sha256 "ffe2e849dddaeb7129fcc590be46e5049c7a8715b77521245b27bfe681bd08be"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.25.0/aos-linux-amd64"
      sha256 "45e24ac9d5a88a0c52997faac9b24f94b1394982633166d58b6105f2eada0696"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.25.0/aos-linux-arm64"
      sha256 "538cf2b535efb27f5a542012a035678c25e3cc4e3d8fa1a7b7e2eacc48b1f9c6"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
