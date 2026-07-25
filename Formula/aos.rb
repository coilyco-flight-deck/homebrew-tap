class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.93.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.93.0/aos-darwin-arm64"
      sha256 "8ce8b74d3ab00a49ab9d0a19341f57f4a48ccf55552b399cd633f5ee1f5f9a64"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.93.0/aguard-darwin-arm64"
        sha256 "572104aa3fecc612bf171b2cbeb0014885cb0bc10f24cf13a9c3670f570513ff"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.93.0/aos-linux-amd64"
      sha256 "7f3b4b8b0cb7709ecaaff0b2d44a4d38e3da23719c9a6a6f8c22e40410ef783d"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.93.0/aguard-linux-amd64"
        sha256 "cb77c4f80be5136fcec54c984e9d7235e94e79556a6a3c3ab206f6f327abde49"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.93.0/aos-linux-arm64"
      sha256 "d6efd9ed939a4fa9a5b626c2532973082641496f9ae06e922e451cc8ccd4f5fd"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.93.0/aguard-linux-arm64"
        sha256 "2b12d7bd0f69fe0719ff4448458978fb6cff050927c7c0eeb2b726dd48d0d87f"
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
