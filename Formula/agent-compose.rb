class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.70.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.70.0/agent-compose-darwin-arm64"
      sha256 "22a55d08dfccb7278d0cff5b8312a2cf61bfb5587febd7ae1b99aecdb2b1c167"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.70.0/agent-compose-linux-amd64"
      sha256 "b2b0809e5c44cbd8383d20691608bd05c0d92c64ac56a32dd29479557f03a094"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.70.0/agent-compose-linux-arm64"
      sha256 "6b4409b6ff32ed259e975612a946432a9346e028efe2b754ff821720daa61802"
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
