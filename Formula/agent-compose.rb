class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.35.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.35.0/agent-compose-darwin-arm64"
      sha256 "16fee5d1fc61d8cbac7b1c308bfa4a611f08105328921573699f76f768c08ca9"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.35.0/agent-compose-linux-amd64"
      sha256 "b88a173fa6fd7a835a0d7ac0bfafb43719ee39255b934b2f8290dde874651838"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.35.0/agent-compose-linux-arm64"
      sha256 "ffa1933ec098aac231b0a8c7d11e57d52c9c0462a0dcdddec11bdffe8ddefeb5"
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
