class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.9.0/aos-darwin-arm64"
      sha256 "b9b2afcfd0a35370a8a5d4a3c708e868570768f00308a8e11ad99a4a334d00fe"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.9.0/aos-linux-amd64"
      sha256 "81c7f469fc3b8909d68b75c9094f63add5a6ddc619da89fddf92f3c6a098e652"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.9.0/aos-linux-arm64"
      sha256 "f840f68db059634dd950ba9e4182cde670369b1559b108f112b24e90ae67ded9"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
