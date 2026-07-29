class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.118.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.118.0/aos-darwin-arm64"
      sha256 "66ad23a3f49c71a5927ee6342a78fa0a8c1d2348b4ad0aa360df16bce97a00a0"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.118.0/aosguard-darwin-arm64"
        sha256 "14253aa14efb1a77ad263d1c6fe5ae92fef69344f06cff74f19ebf45a3fc46c9"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.118.0/aos-linux-amd64"
      sha256 "ac641bb2a7e651dad48cf758579f86a7d4b41c2bdc1b03b0fcd92676161dadb9"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.118.0/aosguard-linux-amd64"
        sha256 "9219a6896d7dc4915dbd57baba9263e041b4141625747af8f6a2c003f5117e6b"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.118.0/aos-linux-arm64"
      sha256 "d951561041fbe8b1aa0c0be98145a84b3fa80c6e158fb372aa49849751d96e82"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.118.0/aosguard-linux-arm64"
        sha256 "55e64e9fe764ce820159a4b07ab8ef942bf604ecd5e62841194b67555dda2519"
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
