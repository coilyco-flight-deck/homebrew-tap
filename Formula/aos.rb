class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.27.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.27.0/aos-darwin-arm64"
      sha256 "555c0be0f370a4b2ebec2d6c081ff06d5e333456579c4908b9cc7303e7c721cb"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.27.0/aos-linux-amd64"
      sha256 "c9ce7e31dedcb4d862379e3bbbc8607070a48785d8495f1bb5cbb3b7f43f78a7"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.27.0/aos-linux-arm64"
      sha256 "226a3c2106671682d0a5796737821ff5a37876b97fe5cf898cb163928d9d200d"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
