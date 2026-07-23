class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.7.0/agent-compose-darwin-arm64"
      sha256 "dace774756cd45ec6bacd7363476a388bd8914c7ad6a72e163a9970a46de9be1"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.7.0/agent-compose-linux-amd64"
      sha256 "6fcf657f0c6fb85488d10d2e58435c0e583f3be293ddf1006cca1b46ae490e4c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.7.0/agent-compose-linux-arm64"
      sha256 "5ab49249350ade2bb46cb6c0b0aea03e8c288f3f77aa7e7b08be995b5cec08c0"
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
