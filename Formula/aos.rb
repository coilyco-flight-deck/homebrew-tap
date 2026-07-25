class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.80.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.80.0/aos-darwin-arm64"
      sha256 "396f6102622cd378ec25b85e97bdcd8c732d79fad0ab3cf38ea14e88b96875b6"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.80.0/aos-linux-amd64"
      sha256 "c800eafc9e7a443ae8525af67f4f32e390eb3b600d4524b2c118dd929681dc7a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.80.0/aos-linux-arm64"
      sha256 "08e1748f06f73bd4a0befc7a9afb0b869675b99df6aa9905b00c660890a81a68"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
