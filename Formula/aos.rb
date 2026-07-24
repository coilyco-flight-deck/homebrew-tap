class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.24.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.24.0/aos-darwin-arm64"
      sha256 "7e997ceb99fd4c4c1231658600320589861f40b21f1b8f59ee828601c897e6d2"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.24.0/aos-linux-amd64"
      sha256 "d6b2dfddf88816485ccd8cfb0e5c0c7ec7cf83797c2f7ae4e1c1831c78efd189"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.24.0/aos-linux-arm64"
      sha256 "1406543a177874ab642e81bf27723e4ceb6ac003170586b9446b448193137fdd"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
