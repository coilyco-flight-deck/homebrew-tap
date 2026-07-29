class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.134.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.134.0/aos-darwin-arm64"
      sha256 "d89cdfc3f960eacb8b4ab3bd267bf29efcbc30d6695a2af4d02c05b2291030a8"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.134.0/aosguard-darwin-arm64"
        sha256 "580c25077cde78f5078c51fa7b4a03db86e4b6af0881d35ef39d8129e748cbc4"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.134.0/agent-terminal-darwin-arm64"
        sha256 "23979f5ffcf3e421f143e8fc8dc60932ec306b74a0aa7251140f1d49f53b0703"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.134.0/aos-linux-amd64"
      sha256 "eb152ccbbccab91f204477c7a58dff43d899274e4a021a54f60391a1b9f45932"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.134.0/aosguard-linux-amd64"
        sha256 "26616b11b49835b60a53510646c91873b137b234053a3a12305880491d915112"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.134.0/agent-terminal-linux-amd64"
        sha256 "c0bb7a6800a79c12db2c3a08588bc1c3c614f7830f90ddc250e6b7020396dc9e"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.134.0/aos-linux-arm64"
      sha256 "5d7919d41098e442f97be3be328276cbe667a56ba049d6e41a5dcd2e8e757c58"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.134.0/aosguard-linux-arm64"
        sha256 "55533c2d810f2db1c401bad4108d4c74b32e91cb6565dfecd2717ca083bef37a"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.134.0/agent-terminal-linux-arm64"
        sha256 "3809b72a696965f6d325525cc3a4476c2b89f0a369088bdc8857272e16d16de6"
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
