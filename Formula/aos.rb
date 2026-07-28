class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.116.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.116.0/aos-darwin-arm64"
      sha256 "1f2c3e21e1462500a2f3b535dae8cf41199d14d331f82137d398765f8e88f4c9"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.116.0/aosguard-darwin-arm64"
        sha256 "a9ccbbaaa29f85918a0b32e411040de6039f3228036b01fc00c8acac716e5b16"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.116.0/aos-linux-amd64"
      sha256 "8cfdcfd46e4abb4c6b4b0cfd34a392ed3e3c2b00042109eb6d39450b372a6a4a"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.116.0/aosguard-linux-amd64"
        sha256 "28ca6ec029e65db5c0201eb0fdfab563da267fdd2d5d9dc0846c708ac53b3aa4"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.116.0/aos-linux-arm64"
      sha256 "155942fbc57d9db8dd014ad19009fa901d81820260ac7b388e2a541e8368a119"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.116.0/aosguard-linux-arm64"
        sha256 "23758fdb54259f84fbd232d988077c9aa3eb77c87251baaa2cf28487b2a0abdf"
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
