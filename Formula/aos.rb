class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.68.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.68.0/aos-darwin-arm64"
      sha256 "7929e3b188642c8037aff38223f784554bc2a00024320dd282efea42866b6ad8"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.68.0/aos-linux-amd64"
      sha256 "43f338085ed7181f71a908e1f8ea6f734e21e4ba216723ae7913431a4f5aa80f"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.68.0/aos-linux-arm64"
      sha256 "039c919b34cd763501a226767da295b94df697c57e8267923ec7143b27612f25"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
