class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.5.0/aos-darwin-arm64"
      sha256 "fc28577b6a5abd742d653dc1c500238b3a6cfa66cf1fa9ecd233582d4e58d12f"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.5.0/aos-linux-amd64"
      sha256 "42dc1d53d51c3c21682cf1841a4c2ec1e55b8b2d328abc55bfdf9c39b38f8487"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.5.0/aos-linux-arm64"
      sha256 "a179bb71e01e30ae6e743bb6eae0a6200c1dcfccb9cd79e23e1b6c2f28406af2"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
