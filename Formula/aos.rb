class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.73.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.73.0/aos-darwin-arm64"
      sha256 "2aca289f03dbc954f5cb8e361ca70a5ba3dd1a4b76c167ac72dfbd068935ba14"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.73.0/aos-linux-amd64"
      sha256 "9c13b4fd0e168ff4150b379074a2af2c1e31b070a11887dc5072226d69f01d45"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.73.0/aos-linux-arm64"
      sha256 "d8cbb557511606d5b434d4df1011178fc91698168d04166f0ed55480f1ec95a3"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
