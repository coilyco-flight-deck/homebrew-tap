class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.111.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.111.0/aos-darwin-arm64"
      sha256 "6c805aa41e62985908f91cc5c124a366857244b9b104df9af97696fe81987c43"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.111.0/aosguard-darwin-arm64"
        sha256 "ff6eb42a02a4465f6e8eefa6c60abaf9d6f67f19ca44dced40522fe0611c87a7"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.111.0/aos-linux-amd64"
      sha256 "e706c83fa19332e927ca6da729451c2e0ba6196098b6d4ba83987645b0f24117"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.111.0/aosguard-linux-amd64"
        sha256 "5384f3a15d981b31c9cf04762f8912d2b0e5f364af618726a96ec9648aed89ab"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.111.0/aos-linux-arm64"
      sha256 "9e647f835c618ac8cd41fdf3ffa26c91f1f0d8a739922f285936d48ddaebadc4"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.111.0/aosguard-linux-arm64"
        sha256 "1987cb4a664c13c7e908b54e3a659b4d44e84550dce7a64f7d93b8d0b383092a"
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
