class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.124.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.124.0/aos-darwin-arm64"
      sha256 "456f82227ce9aaabcb79625fef141512c571bc0f766968e0efbfbb04ca4daa25"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.124.0/aosguard-darwin-arm64"
        sha256 "dc0783f02dd5f024872acfaec37bf8e1c86dc271055189181d0cec0f057ebcc1"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.124.0/aos-linux-amd64"
      sha256 "c915479156c9d101ac54a6644bd872f00f667040a38889fc817614a4aac8f725"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.124.0/aosguard-linux-amd64"
        sha256 "55295464d676c88076497c3919d2fd3556463f5008716b976a3ad709ce09c804"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.124.0/aos-linux-arm64"
      sha256 "e3bfd571841e00cb9a141cf3dec01807d90ffb209c33cfbc6e7e79f4944ac796"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.124.0/aosguard-linux-arm64"
        sha256 "cf189a386c4d57ed5751b2f2ab18e763b86cf65c99009f6b73853be04fc344d4"
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
