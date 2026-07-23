class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.4.0/aos-darwin-arm64"
      sha256 "c382c43dc9607280bf82cf60aaee9c120997bc55ddc82aa1b0ab5da7fbd2ec98"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.4.0/aos-linux-amd64"
      sha256 "dd006aec610196f41590062a7711328fbdc3943a10b5d5bb0f406bd81a8a8bcc"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.4.0/aos-linux-arm64"
      sha256 "32f31dac7a6754bbd83d629f7a2a7a7588824aa706964dded88c032cc5cdd665"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
