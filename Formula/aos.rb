class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.33.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.33.0/aos-darwin-arm64"
      sha256 "9f4633db040d6987d88af1f57359c1ac028283d20cdcaf185c668458152a7413"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.33.0/aos-linux-amd64"
      sha256 "f292510d40c1c47ae514d45428c921fa121599a3eddbc80a2f47eb2b636f271b"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.33.0/aos-linux-arm64"
      sha256 "32d09bf10c9a8598252a374a67e5b3fa674f7df33124c0fdb13550c50a379cb6"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
