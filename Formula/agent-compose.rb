class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.34.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.34.0/agent-compose-darwin-arm64"
      sha256 "ce93101a828e06f4c05447db5882353978e08a4cfa172800bb0d48260eb0070c"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.34.0/agent-compose-linux-amd64"
      sha256 "5cd236a3eb1eacaf8b54447aa5968cda08cf58abc006806432100f46bfc8f4c4"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.34.0/agent-compose-linux-arm64"
      sha256 "5af14834bbd22d4af62243aa49c8ec588e86b777aed256e627eba1431760f5bf"
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
