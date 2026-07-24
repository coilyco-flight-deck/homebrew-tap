class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.26.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.26.0/aos-darwin-arm64"
      sha256 "db50dfc7484cdd0195e5ecab9b37a369029a4bc59cde044f9b4f72de991a0630"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.26.0/aos-linux-amd64"
      sha256 "a1df2170dd597053c65792f11ec770a7df8ebca290260334969a824dac5249b5"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.26.0/aos-linux-arm64"
      sha256 "d981dfececf6b1918c0a871671244048287414f0b076bc30d2410a4fd3a35ba2"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
