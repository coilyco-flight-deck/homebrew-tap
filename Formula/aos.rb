class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.21.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.21.0/aos-darwin-arm64"
      sha256 "0b77066bed21e7738c06fb40acf3d5bdd444e6405843349fa8b7161b6cd2f144"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.21.0/aos-linux-amd64"
      sha256 "dea66cd31cc7757501dd8032a75db07a462d4b896669dc28ad431fe5a72087f1"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.21.0/aos-linux-arm64"
      sha256 "0830c933f74173caa75c8d173ed9bcb35ed9cea416e60f56bfc9f77bcc2f5942"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
