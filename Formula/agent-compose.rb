class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.65.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.65.0/agent-compose-darwin-arm64"
      sha256 "7e75f6f2de23c0f5083a75fd1b921d7a1d4832ec14d18100410a0e05d4697d2a"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.65.0/agent-compose-linux-amd64"
      sha256 "b424b8fea2d1a9378dbe6612893371d799adb23e9cef49c17e1c45ccb7538e30"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.65.0/agent-compose-linux-arm64"
      sha256 "8aa668e0d69d0fd245914de97c973a90f039516e8d4af9b2993aab441a1504d5"
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
