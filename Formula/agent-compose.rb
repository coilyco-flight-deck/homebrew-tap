class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.64.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.64.0/agent-compose-darwin-arm64"
      sha256 "88b5c8949afd76ee05e00d9caa69a4bcbc9805aece9901d50c8eb9bc700f8fd9"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.64.0/agent-compose-linux-amd64"
      sha256 "8d19323ece933877a4918045cfd4925a24595beb5a6fd654720e8095c31626a8"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.64.0/agent-compose-linux-arm64"
      sha256 "87b5f9b94f1300854ba350a03f6c68870e7c5e55b44fd47d746200b32f246f32"
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
