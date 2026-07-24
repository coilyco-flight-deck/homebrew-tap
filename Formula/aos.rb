class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.36.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.36.0/aos-darwin-arm64"
      sha256 "78a3fe2d9cc5189ef917eb29547160b8dadbacc6748658b5984e2eae2167b3e4"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.36.0/aos-linux-amd64"
      sha256 "1eb1fee8feeeb04312d03ff438d98cdfb7ab117895cee4adfba7d5ac40ee5395"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.36.0/aos-linux-arm64"
      sha256 "820e87c37edda398cc2fccdfa9f000d8fe8f2106050589d545fbf997cd21fc00"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
