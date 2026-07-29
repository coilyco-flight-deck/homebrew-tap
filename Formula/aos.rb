class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.127.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.127.0/aos-darwin-arm64"
      sha256 "5c62f5800c8e08b940459dd45ee2678ac7870adc5c4571b63f4a2d9e35963b37"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.127.0/aosguard-darwin-arm64"
        sha256 "b063b8bc716732a1526890a31da51a2f8ae1846174149fe1d10773fba1b52cea"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.127.0/aos-linux-amd64"
      sha256 "9cd37ef9a4a31a5bb2ba1ff66dc7b94b25229c429e15e5b5d28a788c92484c20"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.127.0/aosguard-linux-amd64"
        sha256 "4da44920c28b623061514e6bbdb8302e560d0e42bc5b05994d302e22ca1c8abd"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.127.0/aos-linux-arm64"
      sha256 "c3d143c50e6c3ccafb758a48cb2de5940d865c53b1a144652aa6eaa16ad6c762"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.127.0/aosguard-linux-arm64"
        sha256 "565700b45ce4773910fc36cc23ca5890cebd60ccfd1e0c5f7109c857d7eb8ff0"
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
