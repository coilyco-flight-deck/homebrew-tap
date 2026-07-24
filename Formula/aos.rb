class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.61.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.61.0/aos-darwin-arm64"
      sha256 "5c450a8f383fe722b2b7d9d1c6da73f0bb4092c8586f8c90ef19a323dfcec6f5"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.61.0/aos-linux-amd64"
      sha256 "7e6bd1ed6ad6a190be5eb4c57364425124312024957f15d4d7ca287e476b3d25"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.61.0/aos-linux-arm64"
      sha256 "85bde81ebef01b46cc780f7ee51a7de655f8cc6148752816b97bb839f24f5ac9"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
