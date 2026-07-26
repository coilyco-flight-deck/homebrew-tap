class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.94.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.94.0/aos-darwin-arm64"
      sha256 "fbdc7c22d58aa389422d8c336ad3db496d3091aaa105526062c9a55ec5c69d39"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.94.0/aguard-darwin-arm64"
        sha256 "4dab41940b122a98a9278635be5692b6d59ddb8e38f14482948c59dbea4049f4"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.94.0/aos-linux-amd64"
      sha256 "75887f482ed1627ca9fd3b5541f682c2b78b2d68c4121baeecc2dff653cabd62"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.94.0/aguard-linux-amd64"
        sha256 "0a3af3a52dcf9c0bbd0f78812a2004b623b4cc6bb75cccabe550d7769ed8cd24"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.94.0/aos-linux-arm64"
      sha256 "642223b116e61208b4d58132fdf1fbade1fdee989cad4241a95b0a18ac2f7d63"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.94.0/aguard-linux-arm64"
        sha256 "2d7b9d78b8adc4dffa0810880ce4dba1bde0ae6b1dedcbe15816d95bd8db2428"
      end
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
    resource("aguard").stage { bin.install Dir["aguard-*"].first => "aguard" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
    assert_match version.to_s, shell_output("#{bin}/aguard --version")
  end
end
