class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.56.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.56.0/aos-darwin-arm64"
      sha256 "ef79f4cccc4da0e8dc5d7e9f22e1be9ca010e33a13321dac5f238711db66f2a4"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.56.0/aos-linux-amd64"
      sha256 "f07199d31ef5be4093b4f3daa299c960921fd54b2ca8b4b6efcf77fad31ac4d6"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.56.0/aos-linux-arm64"
      sha256 "8f84d02cd14b9ffac8b2b49e3fd1173596be4489cd40049574983fa41407a408"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
