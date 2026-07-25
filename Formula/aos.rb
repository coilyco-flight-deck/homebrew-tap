class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.92.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.92.0/aos-darwin-arm64"
      sha256 "020c6748e94b0387a77f7410e8a56887c96bcbb91bc93c1dc2c4666350511baa"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.92.0/aguard-darwin-arm64"
        sha256 "6ed92133a36afbc15b1cf1d7d28d47658392090068d1c84cf9a8b4f5195af5fe"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.92.0/aos-linux-amd64"
      sha256 "b1dbb3ec3a942703d18f1658449d7b1c83a8e22284b54093d0ceba97222fe8e0"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.92.0/aguard-linux-amd64"
        sha256 "98e7fd1aad751e6ad8f5552b0b4eec29c1a9d9a80f7a6088def21b6288950200"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.92.0/aos-linux-arm64"
      sha256 "70483b3e041bd1679a3f8206dc2e1b3d0ac9f073b6c74f8fa61a082dc2f364c1"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.92.0/aguard-linux-arm64"
        sha256 "20b82233ce9e2de40558208c79032c26c18bf8557535b19cc7ce79b0a0f9419e"
      end
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
    resource("aguard").stage { bin.install Dir["aguard-*"].first => "aguard" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
    assert_match version.to_s, shell_output("#{bin}/aguard --version")
  end
end
