class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.96.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.96.0/aos-darwin-arm64"
      sha256 "f087f3dd443c240bf942f5ac82e84be66ae29df34c58a854b87862c81e21aba5"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.96.0/aguard-darwin-arm64"
        sha256 "3bf38db88f2c0fae955a9f2f52f8f546c668945164a58333f9dc8cfdce7cfc4b"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.96.0/aos-linux-amd64"
      sha256 "ae7941f2c5bf6cdc32f3806373c4f02201f7b540a360708352daf46bbd881e2b"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.96.0/aguard-linux-amd64"
        sha256 "86bf18864db7c58d5a265125582df999660a591266c5786898302040d9944602"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.96.0/aos-linux-arm64"
      sha256 "c75fc8a16e948934e944dc8f277f267ded3a48c5d3d42b1a5d547b215e47f3e6"
      resource "aguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.96.0/aguard-linux-arm64"
        sha256 "162709d90573feccb94d7245d09c642e780d3b6d89fe60bae8bc3fbe1a1cfe81"
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
