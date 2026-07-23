class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.15.0/aos-darwin-arm64"
      sha256 "50e534367073f4144388031e6a5ab0701ad27a3b25a18de1e38abec98f4bbe42"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.15.0/aos-linux-amd64"
      sha256 "30b1d9a8e449d759f9f9ba6d357f6d3d5c2ba8e0587402d30331d647587aa3a7"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.15.0/aos-linux-arm64"
      sha256 "912242276b8902831c85e3794e0050fc21f52615a3e866585a36f2ae830aa570"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
