class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.12.0/agent-compose-darwin-arm64"
      sha256 "8c22bfc1d19178d3f7fd67c28663cd128b710250745d912a31c98d212cf8a670"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.12.0/agent-compose-linux-amd64"
      sha256 "0f10881c2b0fe3781d87d5fc77f4914b2aa654770cf67b4fb068f413b8981a1f"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.12.0/agent-compose-linux-arm64"
      sha256 "fe9e5b5a72f240ed203c90963bdffd329b9db9920abb6d3c93ef5a66dc71a0ce"
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
