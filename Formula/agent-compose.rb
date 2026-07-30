class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.44.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.44.0/agent-compose-darwin-arm64"
      sha256 "cf8d6adc1e6b8fca8e072e6141ed7fbde5caf1d28e47b2bfc077ccc14676719b"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.44.0/agent-compose-linux-amd64"
      sha256 "2de331640150e38c7a46757de3b461e91110378b36a2ed3037f065a2a0ef53fa"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.44.0/agent-compose-linux-arm64"
      sha256 "5f0bf67e8129dd15062df7408e061ccae70ec9b5e58666d83e192ea2bce9b9bb"
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
