class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.69.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.69.0/agent-compose-darwin-arm64"
      sha256 "a2c952d1f4cd6ac77cff8b44d17a451211706ce926f3f8a4989d655d8475192d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.69.0/agent-compose-linux-amd64"
      sha256 "4ac9a07ca3dfd290aec70f70179a49028dd15e55abe214b0daf98945e5463769"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.69.0/agent-compose-linux-arm64"
      sha256 "7c3a9b4d22399abede7fad37b7074c6fed6272ba416d278b5de7f6c7d4ad5be8"
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
