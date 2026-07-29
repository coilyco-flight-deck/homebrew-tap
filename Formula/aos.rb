class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.120.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.120.0/aos-darwin-arm64"
      sha256 "3e0bd9a9e22dce2902651f4bda8ea7f4cc5c2608204593b1f080df3fcca71924"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.120.0/aosguard-darwin-arm64"
        sha256 "51bbc39f320e3199f3e7807fdcfe9c51b7faf5a0c85243780a94581f89c1f445"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.120.0/aos-linux-amd64"
      sha256 "378fd98075a97f58f241853cbd088721b9ae56731002bf85f631a2a6cdaff7ae"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.120.0/aosguard-linux-amd64"
        sha256 "974c1f1eb987561b4a210e59c2a0b41f3f434275124752a90f0da2a02ef9a784"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.120.0/aos-linux-arm64"
      sha256 "6ced45d1cdfc8413a16e2f4b31bf5c2dac63343877df8980d99d31544c0e74e8"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.120.0/aosguard-linux-arm64"
        sha256 "3a502f6d74978d8cdaaf70a7f2d770ed489c8606a263427e5c368a45affca292"
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
