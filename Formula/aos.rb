class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.58.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.58.0/aos-darwin-arm64"
      sha256 "0b021f008457b75a8bc01c5c7743663434dc931e1025585bf843dcf611d15d65"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.58.0/aos-linux-amd64"
      sha256 "2ebae3abb56814a27d2dd24e09125beec5a9b72f83a14d039b947f5f64be3f6b"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.58.0/aos-linux-arm64"
      sha256 "4c3e4a760e1a72f24b05e49925542d52d2ee7dd52aa6f9aa6a6a8009ee527ab5"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
