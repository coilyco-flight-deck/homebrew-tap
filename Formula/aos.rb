class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.6.0/aos-darwin-arm64"
      sha256 "3b61efc097b5373b57757512f66e0b737e99f27f9f20c612baa61d2dbcfa2c35"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.6.0/aos-linux-amd64"
      sha256 "92618fc91f3d2c6eba83c5903433f8de93d3e0c64e2764ab9861541dbb75a745"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.6.0/aos-linux-arm64"
      sha256 "982c871b6ad415ff61493a519773287b963a4cca5057e4508da75d9d6aba2897"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
