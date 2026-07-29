class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.129.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.129.0/aos-darwin-arm64"
      sha256 "63faf6e652791c96dd9232753d3457bdfe90fd8212e57228d996d8bc1c3a9f89"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.129.0/aosguard-darwin-arm64"
        sha256 "214d94ad614b545e49ae26756c7f408cceb4bf9a8783f89d94e2545208115265"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.129.0/aos-linux-amd64"
      sha256 "d0174e1933d1aece1868742c799803c2e1b018439de7d5699d8c389350015220"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.129.0/aosguard-linux-amd64"
        sha256 "df6ed450cd845ab95b1b6cd236472d88b46f39f35143316ce1568f9632dcf70e"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.129.0/aos-linux-arm64"
      sha256 "5d019c84d41d9e65bb080d206b27f482d99927f232c4eb6e5e37556faa3ebed6"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.129.0/aosguard-linux-arm64"
        sha256 "a59051e454e0577d0f2fe70a9b0674f6ffba3885ca6360328d21b8c89d5c034f"
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
