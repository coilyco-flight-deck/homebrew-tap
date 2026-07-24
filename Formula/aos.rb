class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.64.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.64.0/aos-darwin-arm64"
      sha256 "e879bb6da827c09092fcf6b349acf0e5daa867118c484056ecdafa2ebe359b5b"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.64.0/aos-linux-amd64"
      sha256 "48e41b3eb7c4d05dd032337ad2510c31ee6fa99b2ca5fc622ada182e0c98835b"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.64.0/aos-linux-arm64"
      sha256 "1f852666f117e68ff9e250d46685a440ee5c427a017ac1e8b0ba457bd8132776"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
