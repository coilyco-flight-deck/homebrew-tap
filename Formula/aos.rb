class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.38.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.38.0/aos-darwin-arm64"
      sha256 "36a026ee74472c3af5ad042d7cb297a5261957df52d8e723149e73000fef44b9"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.38.0/aos-linux-amd64"
      sha256 "9106ef32c0d60a57818ec1dd7a04dc52d406dc5917a72981ca6fa1c9b54de169"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.38.0/aos-linux-arm64"
      sha256 "0d664cec96d8d1069b5629f73c31eedb0e303e3c2d8c6311829d81b2fd467fdc"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
