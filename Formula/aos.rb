class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.125.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.125.0/aos-darwin-arm64"
      sha256 "b4e3d3c5a272265526223fbe81962fcee6eb44a2ee07ad62e814272ed847fc00"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.125.0/aosguard-darwin-arm64"
        sha256 "64b0f1c743f60b4246c20dad4c95874a6ff713e34827ccce0921e5cd9e3630d6"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.125.0/aos-linux-amd64"
      sha256 "a75cc5fbeefbadf7048c1c90a9363f3baad0ef046275f9ed91f444555fcf6cf8"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.125.0/aosguard-linux-amd64"
        sha256 "af22c094ac72106fd2f8b57d80d1164f0c5fb9f06ac35dc53ffa1c88ce6fa368"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.125.0/aos-linux-arm64"
      sha256 "03ce295aa051849eb54cc0f34131fdb56f4eddb1a691dc501c083fbdfa638cd4"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.125.0/aosguard-linux-arm64"
        sha256 "b0434b7bf241425e9050a0f0659850a12a6695c3c69719752b2be5b8deabae71"
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
