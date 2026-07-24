class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.60.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.60.0/aos-darwin-arm64"
      sha256 "fb88d12769453cf2c9499fcde8b8ea2f8e66602c11ac6dfe4fdc4193f0beeb49"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.60.0/aos-linux-amd64"
      sha256 "650f151069c5457f84a8e4c69ce45a6e7a8f7bd9ed954bc5bea7973526f49ed5"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.60.0/aos-linux-arm64"
      sha256 "6db4cfce800a483d24fb4a408bf179e678b200e487e38cb892290464da5d0a30"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
