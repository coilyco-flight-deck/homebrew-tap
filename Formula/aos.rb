class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.45.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.45.0/aos-darwin-arm64"
      sha256 "8586fcfbd765eb36f238bab662b6f56c13ff76650cbc67fc0086f416a6918894"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.45.0/aos-linux-amd64"
      sha256 "86576f9af14a03eaef1ad559e130e99d094adf3709c18f932649fa34e68f8293"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.45.0/aos-linux-arm64"
      sha256 "4f0ba9971fac8a6b92f11b0c2cdd5f1af84d9caaaf82b65aef2796cf5ebb0374"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
