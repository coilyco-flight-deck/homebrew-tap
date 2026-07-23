class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.18.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.18.0/aos-darwin-arm64"
      sha256 "9ec1c53c824ad8c5e5e6ff141aabae835da4671348c1bf5e86bf7b755ae5e2d9"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.18.0/aos-linux-amd64"
      sha256 "203dcdf1b9d0970c0c9f267e1164c2ce3929845c4cc438950dcde44624cb92a8"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.18.0/aos-linux-arm64"
      sha256 "d692f13708728a048ff179a2e64836897f8b7a80bebc6750f0f71e6e70c3bd68"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
