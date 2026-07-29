class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.36.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.36.0/agent-compose-darwin-arm64"
      sha256 "97098234a34c538f48755c2dbd7e0edbcff7feaa46acdeb920626ca7b89a4ae4"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.36.0/agent-compose-linux-amd64"
      sha256 "1b6c3b9a61ce3ce28f8500016389fcd538a3c6efcc30bfd46df2a1e1b5db1d14"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.36.0/agent-compose-linux-arm64"
      sha256 "bceeddea0f0146b76bb49f94646557b122826b694d84d2978f87f87536468bb7"
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
