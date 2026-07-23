class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.11.0/aos-darwin-arm64"
      sha256 "001f82fb5ac671e9467708c7860b32cc1e15fecaf8dfe08920f03f31a2f09434"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.11.0/aos-linux-amd64"
      sha256 "6d4c107529cc70c0992ff00204733757ab38ff3461e4a76dc8455b3abe0b6140"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.11.0/aos-linux-arm64"
      sha256 "c782551660961543de40c154d7db3b0c6e2f2887a566c977bf4c72c74305e4e8"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
