class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.112.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.112.0/aos-darwin-arm64"
      sha256 "e2c9352d601ec01e7b6cadcc9196f3dda860542a275076add2bfba2bfa43efe7"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.112.0/aosguard-darwin-arm64"
        sha256 "79624bf68d8794b06f6eee68ef94a418aa6aa7988ffd683a0148856e4ae14ed6"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.112.0/aos-linux-amd64"
      sha256 "a8f178a017c5c7fe7ee083e40f66e923dde0d692fbb614dddef1f434258f1b6a"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.112.0/aosguard-linux-amd64"
        sha256 "2e82d198779ca81150aa4ac4bd36353fd5aee5ce8a1dd672cabfecc4a6b54db2"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.112.0/aos-linux-arm64"
      sha256 "9d7c19f91801f36406b88e3c9cb8ed57c140f5d41d1c002be093d658952a9426"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.112.0/aosguard-linux-arm64"
        sha256 "0e883640324ad7e0598f700464ca21db8b200aa3bbd2d21bd85782539c552aec"
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
