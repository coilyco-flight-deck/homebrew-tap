class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.13.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.13.0/aos-darwin-arm64"
      sha256 "b039eb9f6972d6ddd74cb678b9ce832655f7da4b3089aa335def2f0011afc7b3"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.13.0/aos-linux-amd64"
      sha256 "96746a452f0f3bb97e568390165f14acafa010073de58503a59711876d0bb205"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.13.0/aos-linux-arm64"
      sha256 "507355f2494450e4be7b301310e66802da66f231da9d9d8b8628786671113062"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
