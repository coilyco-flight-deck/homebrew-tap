class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.72.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.72.0/aos-darwin-arm64"
      sha256 "3ee2ef6890f68fc018cd0c8504a88879b276781eb56b9afdc34a8f0838e11161"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.72.0/aos-linux-amd64"
      sha256 "e4630e83fcc98e49c4889aa67de5197b8e631c31ecddcfc609bebbe12badf35a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.72.0/aos-linux-arm64"
      sha256 "fd5e41f7e203f7ab5b693997e55e459486a6cf913aa25e59e77d7bbf3d6483d1"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
