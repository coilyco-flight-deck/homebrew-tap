class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.106.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.106.0/aos-darwin-arm64"
      sha256 "66a1d7f47b80ce027299acdc84e32ab86f05a3851401a8e8e6e4cb9332845c95"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.106.0/aosguard-darwin-arm64"
        sha256 "1edca778d538223b773091c03528b89d49ae8f7d80946c14f094b11e0fb7e73e"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.106.0/aos-linux-amd64"
      sha256 "60c998d473c75702e22730cb8130ce4d75e93fef08cd85ac5b8e728a115f9734"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.106.0/aosguard-linux-amd64"
        sha256 "5caa7a8a90289f188d46273b955571d8499a088ba48244277f5b4b8d0206ef1e"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.106.0/aos-linux-arm64"
      sha256 "d759784b12e853a50d08c6fadf11fde76513c902822297b03118e46a3023d34a"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.106.0/aosguard-linux-arm64"
        sha256 "cb96dd5544b6a26464cc7f4b8e18c6cecae2e187279c2f9ec0fca02b8a7999a4"
      end
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
    resource("aosguard").stage { bin.install Dir["aosguard-*"].first => "aosguard" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
    assert_match version.to_s, shell_output("#{bin}/aosguard --version")
  end
end
