class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.50.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.50.0/aos-darwin-arm64"
      sha256 "792848e2ecbbe8f9b991c9ef93789a7699d7cb1c09e69790bfc30cb2dc15a5da"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.50.0/aos-linux-amd64"
      sha256 "eef7c84d2cde903a8d4e553cf36d0b0606acc46b30a2d18bb0ba8929775fd48d"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.50.0/aos-linux-arm64"
      sha256 "d04f896746746157eed5f68870e38aa4b2f8e729d2f3d5bd89d42fc78be8e5f3"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
