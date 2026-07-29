class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.130.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.130.0/aos-darwin-arm64"
      sha256 "ec75acd6e820ca0868a8b1480192b76292d59d0b83746ec7a5a89508a6d9fd7a"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.130.0/aosguard-darwin-arm64"
        sha256 "71e552a008b15145d8dd6b4d29f34d24dfe6d35d5e54f0d42c0b0531e2b05e71"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.130.0/aos-linux-amd64"
      sha256 "56410a4044e31eed4b2f29c35fb9304ea5ee6733cb20c868f1335ce48341b9f6"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.130.0/aosguard-linux-amd64"
        sha256 "462320f410fb14ea604a8b7068ed023203c5b2fc91582400821db9e5b2ecd436"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.130.0/aos-linux-arm64"
      sha256 "e1b2d7dba2eb569e3c2b1b3f032ebe001a5f75a829945ceab563d16b1bdb200b"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.130.0/aosguard-linux-arm64"
        sha256 "ff33494db9f1cbcd8e90420dd3826e09c1518b332ee340c378c70250a97e5628"
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
