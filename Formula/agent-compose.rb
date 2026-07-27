class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.15.0/agent-compose-darwin-arm64"
      sha256 "879839a58f06b6c5ae3e12018e2191b96b6dfe6944e769b2f325cb57ed4b8c6e"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.15.0/agent-compose-linux-amd64"
      sha256 "125e4425c495aa4f6667de50646ad8cf448bf5c5e9e89f22562f0a4761e3fd3b"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.15.0/agent-compose-linux-arm64"
      sha256 "09c75b7b063998a1fab684c9497ea483520b26acd328a1f0b4712e39ebe6b1d3"
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
