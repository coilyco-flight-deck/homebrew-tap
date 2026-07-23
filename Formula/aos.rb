class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.22.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.22.0/aos-darwin-arm64"
      sha256 "a706726fbedeccff1388065e193c1e5a633c6dc929c9c5256e0d870ac2687af5"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.22.0/aos-linux-amd64"
      sha256 "a82fc6576f5692ffc53ab7da854dee55c13cfb44729c0edc2aad819ba24a3641"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.22.0/aos-linux-arm64"
      sha256 "d3bd5d80900a68f4d80386a21c2a42cc5239d96052e390d00a46736cba8157dc"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
