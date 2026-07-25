class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.49.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.49.0/agent-compose-darwin-arm64"
      sha256 "3a1582d3c30da0f47687fef383692c924873de7c9b8b6af6bc9875eb996b2eaa"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.49.0/agent-compose-linux-amd64"
      sha256 "d737f3246bb124e9faf30a92fa187db1b8cad22c14c614c6443207dbb79bd2b4"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.49.0/agent-compose-linux-arm64"
      sha256 "52606f802a8a9ccd998b646847cbecd13c3507eb6794fa3c0c070a0e2668720e"
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
