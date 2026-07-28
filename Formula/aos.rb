class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.110.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.110.0/aos-darwin-arm64"
      sha256 "713734c86baccaccaf9e05c910d44cb1f3d06e0eb1ac91142dcd86f25078df79"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.110.0/aosguard-darwin-arm64"
        sha256 "c248612391e5c175c566e4e1ae8e9fb2b480adffa308a6a32a33f931f8a012d2"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.110.0/aos-linux-amd64"
      sha256 "e1874f9382332d369b7a7843ad37a8f47deb4297e25de2e8999c9cfb3a5de0cb"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.110.0/aosguard-linux-amd64"
        sha256 "a510be9f4284099d94e87e0dcbc3eec52476ddf3b5ee85c142fb70173ba137ff"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.110.0/aos-linux-arm64"
      sha256 "2799ee740684e904e1650de2bb780e53f65db551ff51852ed9b4334d1590cd53"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.110.0/aosguard-linux-arm64"
        sha256 "3b3e5fa30c31d19057092ed839ccd440f2fd0989f8d9aa8faebfcf7de5c3185b"
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
