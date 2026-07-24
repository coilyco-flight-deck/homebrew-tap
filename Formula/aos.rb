class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.40.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.40.0/aos-darwin-arm64"
      sha256 "09f87cdf82d58c451d267d09533cd418c71d35ec69f9866fe6e84a2ca28d596c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.40.0/aos-linux-amd64"
      sha256 "a2c0623c996d8f4ecd823c59674a94ebcc238707ca8f5594887ab06e2a6a16e0"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.40.0/aos-linux-arm64"
      sha256 "4f6cdb174d3963f47aacc65c163041b8d55036d045ef2c9b79f3eea9a995ff1d"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
