class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.29.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.29.0/aos-darwin-arm64"
      sha256 "574c7d43b1eae50841b000a4fbdd0a51b0e60af48260f68b28c1420fee0f08d4"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.29.0/aos-linux-amd64"
      sha256 "a54f8e4b07a67c85a03de47671bc722854910823b347b9c471dc04c2607e9535"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.29.0/aos-linux-arm64"
      sha256 "079286c65a7807d38813bbe219a06c12d1aa7d0853e39696191c53b1ccefa40b"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
