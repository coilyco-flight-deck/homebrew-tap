class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.119.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.119.0/aos-darwin-arm64"
      sha256 "385c1700d369f0be5afd43a16a8966cde3cb8ab07852cafd02142990b0480ed2"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.119.0/aosguard-darwin-arm64"
        sha256 "999d6bf92846d204e3c280e0d26adfef39c96c0d3b6b3a49dae0073ca37328fb"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.119.0/aos-linux-amd64"
      sha256 "c5644ea1e05350e8d07bc9e4fa22aaceeda54be9e7d30ea9b2be4263d9ff36a5"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.119.0/aosguard-linux-amd64"
        sha256 "d1794b70245ad9b900011c455aa46dc151be0d3d71ea16956849182ef0e3e851"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.119.0/aos-linux-arm64"
      sha256 "a220fb77b2f14f1c75afb31108cdbb960acb81f053c187d2013c16089863e066"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.119.0/aosguard-linux-arm64"
        sha256 "6074f92c7655516edd483827952b148163811aa6ab64da5bf685838de6902436"
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
