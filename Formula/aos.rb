class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.39.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.39.0/aos-darwin-arm64"
      sha256 "bd92643e67ee3dd3dbb73a6946c28fb5d37835157cc3d4f16b837d778151dc08"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.39.0/aos-linux-amd64"
      sha256 "a15a081b8624760c715d9a104d86df50e5fd990c0beceab76569a7e26d252c38"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.39.0/aos-linux-arm64"
      sha256 "048b49b1ce381bcf4b5ee5bb1183b05fc72a068d4401cb6cbf9dd3ceb91ade11"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
