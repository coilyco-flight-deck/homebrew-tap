class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.16.0/aos-darwin-arm64"
      sha256 "e159c283d584a74e74eb05ee85b4fbc37169cd67d9275ae45999e21fbe61e3ea"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.16.0/aos-linux-amd64"
      sha256 "05855c57918e9c728281c4e2edfe29c7b4dabc66d363fd4ef13a93315338fc2e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.16.0/aos-linux-arm64"
      sha256 "28cc4cfcf8d0f234d44d2167b2eecd0c38d30a153a1f524eb63a3371a33961a6"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
