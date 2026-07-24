class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.37.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.37.0/aos-darwin-arm64"
      sha256 "8ca1254dc4b225c1fc612ddf6576beeca9265af9d447d8fc6a1a6bd58e4ec247"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.37.0/aos-linux-amd64"
      sha256 "3cceee9c3ed3e5b85d7194a8cd4324b998ac72947fc71e57695bae44aaa658b8"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.37.0/aos-linux-arm64"
      sha256 "4f90e18a9357d0e7b45f7421918fc67830db428b6d9ab01f9e8d18d2a6a0d331"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
