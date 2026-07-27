class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.101.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.101.0/aos-darwin-arm64"
      sha256 "4c9eaf2ca779a321782e0f047e0c920fbbfeaf7312363bbdc1af439ead785687"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.101.0/aosguard-darwin-arm64"
        sha256 "d954bd6a6bf902ac23518dbc1689feed2fe312ff592a97c77ed88843ac5e51bd"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.101.0/aos-linux-amd64"
      sha256 "32ad57dea37a7f5426b54c9036b29048095ee8d1048668914792635729939dc5"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.101.0/aosguard-linux-amd64"
        sha256 "9fb40f29fa3b638c8ef44ff83cd7939112e8515c12d8b75e749f74d03b949ba5"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.101.0/aos-linux-arm64"
      sha256 "075560bf537bd224779e12c1289515fd7979d5982fb27a7f6f6e3acd2e696179"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.101.0/aosguard-linux-arm64"
        sha256 "97113b6c63f70a812e5d66c06af868a8824d0bf0ed7d8485db4ea5acaf489f23"
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
