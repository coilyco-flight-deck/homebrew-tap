class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.121.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.121.0/aos-darwin-arm64"
      sha256 "48dbe1a389b3c0d7ecbe37fcef23d642a15d312919847e4e40cca55bd4072ac2"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.121.0/aosguard-darwin-arm64"
        sha256 "9ade2b6f682a5dfb8d22c65658db51c4e8c47b1002980537f68f51f271f797f8"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.121.0/aos-linux-amd64"
      sha256 "52799af35ce4fc14a48d5e315b6d0f316499d712504a0fa171906a61feeb75e0"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.121.0/aosguard-linux-amd64"
        sha256 "618cf2e0902a217bc455d0cd952d21ce268b9cf62c6cb1807aa6e5e6ff106324"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.121.0/aos-linux-arm64"
      sha256 "523c60013f91526ef5099d0cb402a553d50476b0d204f7fa35eb4a3eece4f6d9"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.121.0/aosguard-linux-arm64"
        sha256 "d3587edb04e21370842dc94a0b83e43c2e16bec3482469275636b9f5d75f807c"
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
