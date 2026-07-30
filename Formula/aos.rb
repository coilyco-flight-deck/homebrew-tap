class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.139.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.139.0/aos-darwin-arm64"
      sha256 "be5430eb3e947f704d020339f0eb3009efcf20dfd2ec79073450e6fff0a06634"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.139.0/aosguard-darwin-arm64"
        sha256 "108666c93f71fb0b144c8216fac642751215336cc8b2a25d0a8816e27340b195"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.139.0/agent-terminal-darwin-arm64"
        sha256 "1dc8fea4f346108d99978052383306ca01ef8cc89e8d8387c7bb2baca4781a97"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.139.0/aos-linux-amd64"
      sha256 "d64397f46f02656aeca502004b51b0f4c9e848f78942cd101499f53e13598320"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.139.0/aosguard-linux-amd64"
        sha256 "8cc3efaf4715b98ffbbfbfd91dbafaf77f162f6538f7a5415d64b29c07e8ae87"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.139.0/agent-terminal-linux-amd64"
        sha256 "573061e38c03f3ae5e552ff3bc0cfb75a6df2fe5a349ee3c00faa7d3623a1005"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.139.0/aos-linux-arm64"
      sha256 "73a5101897bbc79d202788912522eb5cb3baf79b78c7ae791955284b0f3ec622"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.139.0/aosguard-linux-arm64"
        sha256 "0fd5b82e53059a482806aec3ef3d430eefd1d4558c2d423911b6d3aba0c90812"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.139.0/agent-terminal-linux-arm64"
        sha256 "92e6d85b8deff5d1c8ea8aeceef51f8e32837e4f3bbdd0cac14e8cc50bd0b403"
      end
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
    resource("aosguard").stage { bin.install Dir["aosguard-*"].first => "aosguard" }
    resource("agent-terminal").stage { bin.install Dir["agent-terminal-*"].first => "agent-terminal" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
    assert_match version.to_s, shell_output("#{bin}/aosguard --version")
    assert_match version.to_s, shell_output("#{bin}/agent-terminal --version")
  end
end
