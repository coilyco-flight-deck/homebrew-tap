class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.98.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.98.0/aos-darwin-arm64"
      sha256 "0aa78760deea5c3a1f12f6dc35960128d79f95f8fffc6c9ebf1c34587dee8503"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.98.0/aguard-darwin-arm64"
        sha256 "0a6fd0a3ce6efd83f221631ad69e1fce0f0746f9bc9f3251902b89b42ba7a0c6"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.98.0/aos-linux-amd64"
      sha256 "0fc567452fe6b9aea500ba9a5dd51751c8b2109c1cd2f704d030668cd9120d5f"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.98.0/aguard-linux-amd64"
        sha256 "622e208962d575686f12a70a9f3169a53859c02076a7cb8cd23a805889634698"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.98.0/aos-linux-arm64"
      sha256 "b194b24f451a9a681bf6a451e4336c87e53754c0f4f552a0b65cb3c862134273"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.98.0/aguard-linux-arm64"
        sha256 "c52c6151f1d44c65eeb2e20c340174e3223f04cfd8cfb6da8713e30ca585e258"
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
