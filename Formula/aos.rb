class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.70.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.70.0/aos-darwin-arm64"
      sha256 "799cf5d61835caab06fc577fb8fba8b3a7c04fca098246fd38edb482bd6d2df7"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.70.0/aos-linux-amd64"
      sha256 "193bf6e5616752d5d3a7920014806cade9376299f479ae6624a817192e0b29a5"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.70.0/aos-linux-arm64"
      sha256 "60628dc9a010eb5393309e83cb4a30dff2e7141c6cc89bedbcc5a8c808592b21"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
