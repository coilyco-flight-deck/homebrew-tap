class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.99.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.99.0/aos-darwin-arm64"
      sha256 "3b24d5478c556d7315856ae876b431c754d8e3a1bd4048aef95c3971c72d89d9"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.99.0/aosguard-darwin-arm64"
        sha256 "35a122610afc3a8aa8bf65e8ba356aa5df3b727f968b602821d54c2a2bf3c6d7"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.99.0/aos-linux-amd64"
      sha256 "4fb5a76584dc4eea3de1a11f915997341338808fd978a3b2d889677780581960"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.99.0/aosguard-linux-amd64"
        sha256 "c27e943b5563fdc8dbdd7d282580cc26a223b39b5de6e64b2f2df67cf3e2919f"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.99.0/aos-linux-arm64"
      sha256 "b32d8c9d012051a080ce361d7448dd169773f4c87d797966246d23babbdc9d8b"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.99.0/aosguard-linux-arm64"
        sha256 "973324013249b5016e2ee17b1d1e2d31160506fe7e2eda931879bae83777c747"
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
