class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.55.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.55.0/aos-darwin-arm64"
      sha256 "c670eac990158f309e030b43cb7847229d0bb98f3f9c09efad498052d812e5a5"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.55.0/aos-linux-amd64"
      sha256 "66cfc748934269c1c3df3063872d860f675b5c94573eb88cf7aa378882d5a128"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.55.0/aos-linux-arm64"
      sha256 "b6dbbd2bec768c2f47052ce6e823ed9420b50d8b11b31c99ba1ac4b05b16349d"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
