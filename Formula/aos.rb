class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.59.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.59.0/aos-darwin-arm64"
      sha256 "e288d97f0c9eb595828d3eaee392c2232ab2fef5121fb534cae20203b159a5a3"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.59.0/aos-linux-amd64"
      sha256 "50c26cbf72b4e506a2138a1f7fdd7b9ab83f5fde5e0dba3a52cfa8dd3d9dbf99"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.59.0/aos-linux-arm64"
      sha256 "c006140c67e69455095e0f268eea415a353965b5e85eb58afcf5a1320c08fd70"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
