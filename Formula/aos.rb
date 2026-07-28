class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.103.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.103.0/aos-darwin-arm64"
      sha256 "789f0a04aa26d163398273117e137dc6cc57055142273151892c4c0e6949e9ec"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.103.0/aosguard-darwin-arm64"
        sha256 "c260a107d53a220997fcbd797ee97f5bbf57b69417123e46be086c5d7751467f"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.103.0/aos-linux-amd64"
      sha256 "75228c679008fe08d2b7b397cde187660a8d82f1eefda7a225c408a1e595363a"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.103.0/aosguard-linux-amd64"
        sha256 "4922fbf01ae2fe7e2f12a956aeb6bcccfc0ccf97c3c15a76f7da784eb6985199"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.103.0/aos-linux-arm64"
      sha256 "ef6211d83df19cae13a30d27e984877773ef58264e91b1e5e953494f085f1d5d"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.103.0/aosguard-linux-arm64"
        sha256 "a493f6ed7ce34e1d98afbda252075d3a435c59a139ebfde83fa80107d8f4f66a"
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
