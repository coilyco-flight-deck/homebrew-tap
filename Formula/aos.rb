class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.104.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.104.0/aos-darwin-arm64"
      sha256 "67ce0bac3bb97e272cfce704761377b6f4b9580ac214be593d058eb09384e00f"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.104.0/aosguard-darwin-arm64"
        sha256 "7aae4dc8bd2d77ccd05d8353af9a1dc614bcd640f67ecff0d65fc50a8aaa09c7"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.104.0/aos-linux-amd64"
      sha256 "ba12e107bb8e3423adaf30a47c806f4c830bfa08aa45c878959f3e6bdcf116f1"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.104.0/aosguard-linux-amd64"
        sha256 "4f81a6dd55cf585a38047b920fce7769f1e74c1c1cb192cc595fe737cba5e3cf"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.104.0/aos-linux-arm64"
      sha256 "e4ba8280c50f9ed8a82025ea7a3f5506b52d0b5fc1da9b616cfa5b6926e26ac7"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.104.0/aosguard-linux-arm64"
        sha256 "5f389c45780da4955f49b3ea5c557115a3791288853ed92057c8dedf44a87868"
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
