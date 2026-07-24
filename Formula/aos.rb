class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.63.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.63.0/aos-darwin-arm64"
      sha256 "5865f046f44b5d2f84e3b63bf65fe413597f7bc9357c42bebe9240a204cd8472"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.63.0/aos-linux-amd64"
      sha256 "46bb3c7417a2425b84dae5fedbcf03ff38e0729e81f75eef48485044196abcdc"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.63.0/aos-linux-arm64"
      sha256 "48d8ec97cdea5789840d8c2905e79b470759b96dbc23165450161b3412a71197"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
