class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.3.0/agent-compose-darwin-arm64"
      sha256 "d254fbd7d27eded288f04b46fd46e8e611630bb3dad3880bf771b4c48d7102a1"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.3.0/agent-compose-linux-amd64"
      sha256 "6f3f80ccd8555ffbd7e154abca15a0dd646f691215545d4e67db80ec2e225160"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.3.0/agent-compose-linux-arm64"
      sha256 "4828d159e01171a69eec486d1910b9f6c5e67eaa832242ea7c0c284be8699480"
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
