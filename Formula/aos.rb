class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.131.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.131.0/aos-darwin-arm64"
      sha256 "6c1f96d0b42acb992022576a8c0e1cb177171e8f092b330ffb9eeb79237322f2"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.131.0/aosguard-darwin-arm64"
        sha256 "71f7a81c6c110fd42ce611952d28bae55c2cdd9da67c8cfa991e93d68ad6eafe"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.131.0/aos-linux-amd64"
      sha256 "a12269cc6ce5e636c487c9a5153842b764e327e7e6aa84df96e5e553a3d8a9b2"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.131.0/aosguard-linux-amd64"
        sha256 "afe4a5a2c5c304fd0fdcf06e48a189d674b80c9c1eee11a1cc78d00d579c086f"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.131.0/aos-linux-arm64"
      sha256 "f7148715afe0aedc2e3ce04409f63270d687143dac1dbf91e4d296cc826fd292"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.131.0/aosguard-linux-arm64"
        sha256 "7c357bbca8c4b1582cf75d2d88b8fa7cb4f7f7a171b7040b80df973be1688b3a"
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
