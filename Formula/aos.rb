class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.52.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.52.0/aos-darwin-arm64"
      sha256 "64c66643a6b5bfcd127a2025485f9675641c11c71ad1e5ce21e71a5f0b3319c4"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.52.0/aos-linux-amd64"
      sha256 "be927c40cddd020e592a57a234f0e85aa115d261ed6efed5af58c9faf9f6b912"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.52.0/aos-linux-arm64"
      sha256 "93bbffa9a08887549b8cc55b35988e29afcc8b78ac57264624daa1f8aab640a2"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
