class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.41.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.41.0/agent-compose-darwin-arm64"
      sha256 "d9098b6ded31dd30eec37177d323e3492424c0364d00711c9b8060774c15c949"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.41.0/agent-compose-linux-amd64"
      sha256 "2aaa8e97aaf9ba57e8973293c0efc01967424163f9eebeea5e95cc3b10a2fdda"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.41.0/agent-compose-linux-arm64"
      sha256 "110cb8e754d825a87873d4863c26b0dfc293769a7aec0ac4df57666e8f0c9215"
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
