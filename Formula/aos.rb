class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.109.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.109.0/aos-darwin-arm64"
      sha256 "aeeb66cc8ca03293b2ebe0579bae6231f7fcea06c67fae6d3160001416889828"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.109.0/aosguard-darwin-arm64"
        sha256 "8dbd112ce3ba8ed4502b8bd24a9e67534b840326d07fbce10c8dee92e069d3d7"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.109.0/aos-linux-amd64"
      sha256 "9d511992380d93bc19fbad2fdd75812f53f174ed20fb94844d54aa70e1a5ab92"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.109.0/aosguard-linux-amd64"
        sha256 "78d727df67c2ead6f09593f51e42ae891d402915db9eee276a1acd94c15312a5"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.109.0/aos-linux-arm64"
      sha256 "4666c4554db8abb4f42f3416a121fa529ff5f4bbbe6dbf3b6950bbe540983d08"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.109.0/aosguard-linux-arm64"
        sha256 "aaf3c0204f0102de78dc3dd05664fb0c714724a419da1fcf44f3c0417a2f0955"
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
