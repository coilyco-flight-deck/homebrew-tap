class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.18.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.18.0/agent-compose-darwin-arm64"
      sha256 "6a4b1421ba28cf16316584633a52d0ad89ca39579bc3fc52a6b92521a80a49d0"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.18.0/agent-compose-linux-amd64"
      sha256 "9dd3c9f5d78edef9c23dccc4876a5c761be36f69c9313966bd4b336b857b16d8"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.18.0/agent-compose-linux-arm64"
      sha256 "baaeb36374eb2d3a5356ec21d40386f3d8eda01321e5bdbe862c39f316724abc"
    end
  end

  def install
    bin.install Dir["agent-compose-*"].first => "agent-compose"
    bin.install_symlink "agent-compose" => "acompose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-compose version")
  end
end
