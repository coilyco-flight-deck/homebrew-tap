class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.102.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.102.0/aos-darwin-arm64"
      sha256 "7f9a29b8c5f439894725b2282d4e66db1e10a933c0a7e2aa9791d87f2e7046d5"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.102.0/aosguard-darwin-arm64"
        sha256 "00ef50e8e4b1f41cbf7417378450935ad55d102d905ac41a9ef50ca26b10d271"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.102.0/aos-linux-amd64"
      sha256 "e2ed5d84a8893cf672fcfcd55d3a00294927405e8dd308ace33320562609c6d4"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.102.0/aosguard-linux-amd64"
        sha256 "c6c18b8f2996d506b5db5890925d63a3b5e7d1c16a72db1772272f3efca7380c"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.102.0/aos-linux-arm64"
      sha256 "99a19504a0614f321bae78f72ec4ce6b0b32c787273c8c6c9157286f56d5b054"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.102.0/aosguard-linux-arm64"
        sha256 "3f0d4277b140e676f2b2420506dab07c711fd137b4a4bddb8018e737b27f7425"
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
