class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.79.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.79.0/aos-darwin-arm64"
      sha256 "d105ba6ddc90b2f8d366dfcf43d35687394f73378cf12ff98b97f11247928eae"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.79.0/aos-linux-amd64"
      sha256 "4c9e0a1913407ea3ca126477be94196c202d7c1d8638f42e5cd80b6afaffdd03"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.79.0/aos-linux-arm64"
      sha256 "6d410ec80d8bcb799e078748413999b2b01a6b1632d988069ce2049bff7107b0"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
