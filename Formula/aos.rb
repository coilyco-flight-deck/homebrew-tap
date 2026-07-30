class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.135.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.135.0/aos-darwin-arm64"
      sha256 "9c467ab950758f2bbdac388047e6ec8eeb00f95f694e04fe7c654223416ab6ac"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.135.0/aosguard-darwin-arm64"
        sha256 "e01ad804a4461bbcaf89dee49bdcff789bbddf8f9eda4d22d2dda190eadf938a"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.135.0/agent-terminal-darwin-arm64"
        sha256 "9b2aff3f350e2eac9ff710ba5089a3c7f9a2a722ae86aa249712d8d21f9625f0"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.135.0/aos-linux-amd64"
      sha256 "1b588530a0b84a33706bb3af6d568cc9669272d66a4168b04f4aaa71b0c2cbe5"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.135.0/aosguard-linux-amd64"
        sha256 "04731b59a8f0bb57a1ecda3dae40d78756e546092571a1d050d80088321b4590"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.135.0/agent-terminal-linux-amd64"
        sha256 "3e496a0d15e2e2d0e5e63003540056f127414d7c7081ac091d8961b47a0bce22"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.135.0/aos-linux-arm64"
      sha256 "a8a64478db4eada5e4ec6dae130170657bd3bd5b97f37c702b5752c0bd0d4053"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.135.0/aosguard-linux-arm64"
        sha256 "ba184f86f4cb80fee13add2e587934fd0650d29e1eaf2578aafb647a7fada46a"
      end
      resource "agent-terminal" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.135.0/agent-terminal-linux-arm64"
        sha256 "3e8249be1fa35cff7cb8ec8c4b8d8ab363f1b7a6c269f505b2c94fbe6e0a216b"
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
