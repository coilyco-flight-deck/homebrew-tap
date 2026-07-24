class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.49.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.49.0/aos-darwin-arm64"
      sha256 "2803d78730ae5efb5488eb30a25a59dd8f6f9a06cf14be6dd5c993db67c495b9"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.49.0/aos-linux-amd64"
      sha256 "0f51e2660489c48312b8ba278761ac22fcdd508a21acc5dbc163a2e6d6021b4c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.49.0/aos-linux-arm64"
      sha256 "517f8fa5ad507145d6f4fbe17b31a683601fe40144ff5ce41c93f6f0598372c6"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
