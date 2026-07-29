class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.117.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.117.0/aos-darwin-arm64"
      sha256 "1884932875148864394298bca55dda992dc7da96dca3975741fb826aeddac35d"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.117.0/aosguard-darwin-arm64"
        sha256 "c25bf61a9b7c0e12e86f8d2bc0d9b657f98fc1ffb4ee98b8571bf7002e0566bb"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.117.0/aos-linux-amd64"
      sha256 "951259a7dbbe2480fc98cf2c19e23f1cef18f9bc5ae1377211d7636a0652a957"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.117.0/aosguard-linux-amd64"
        sha256 "e0203c5f62f1f156254c9ad95b7dcee3787782ec40c3fd978e5d6d47c9342bb3"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.117.0/aos-linux-arm64"
      sha256 "d40b34953aab77e3c8d746f4ddf70e949657e5832da48a14a5a9749e3670bf9c"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.117.0/aosguard-linux-arm64"
        sha256 "8bc2911f3a8b05ca5de8c1f1027df2e6daf8e2822fd69f178c5e1a172625a234"
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
