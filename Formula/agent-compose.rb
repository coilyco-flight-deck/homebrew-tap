class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.18.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.18.0/agent-compose-darwin-arm64"
      sha256 "f5013c5b29d7347ebee055a036b0d7a6f3c8df5fb7aaa70efa0c7ecd6b5e0a3a"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.18.0/agent-compose-linux-amd64"
      sha256 "4f851fb73723da86acd3bb68681c96d05af08db77ca202d9bf9777ef4bc6c281"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.18.0/agent-compose-linux-arm64"
      sha256 "4cb9cf9cfb7469c9f08ded63d8c681af8adcf1758c8818d97327954a86659596"
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
