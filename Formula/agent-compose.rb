class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.39.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.39.0/agent-compose-darwin-arm64"
      sha256 "f811c9bc5e352bd1fc5e586cbc6bf8a23f0b61fb45b48548a1d1fbaa9043d905"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.39.0/agent-compose-linux-amd64"
      sha256 "632411ea67e26aea164f2bb75722b3b9e0a318be9a0bacd4b7388cb0354ecf62"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.39.0/agent-compose-linux-arm64"
      sha256 "dc99e0c6fb925676ec1fc18ac25a90ab453cf5e97395f6650c42baf114cf4526"
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
