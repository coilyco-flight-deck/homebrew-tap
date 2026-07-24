class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.31.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.31.0/agent-compose-darwin-arm64"
      sha256 "e19a940ed76cbb1c58c2b2d6239f75885e3fabc8cdf95a67e1e46bc5783995dd"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.31.0/agent-compose-linux-amd64"
      sha256 "2825cd3f92f352e8e7e007bbd443f95f7cee7d1198d91cb49691990199a4fc18"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.31.0/agent-compose-linux-arm64"
      sha256 "fcdf529d110439bb4af672c7aae58ef16328dbd6364203587ecd582af6b5d22c"
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
