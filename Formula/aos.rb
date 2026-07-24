class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.51.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.51.0/aos-darwin-arm64"
      sha256 "09ec439f6c4f75055dced630c4cb2cd1e818c830529a4cc0f85bd9bf86939878"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.51.0/aos-linux-amd64"
      sha256 "9bb65666b19c666f2c6457f0f503142bab3bda04122cfe79c58daad09cf24772"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.51.0/aos-linux-arm64"
      sha256 "0971dabebb60dcafaa3bb8e2958986102af85d1a7f38ca58260ba246580789b3"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
