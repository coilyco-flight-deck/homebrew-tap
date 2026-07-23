class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.8.0/agent-compose-darwin-arm64"
      sha256 "d1cdb71eb20d0ce44e54c8593bdcda4cd90fad29549a4cd71407458a3340758a"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.8.0/agent-compose-linux-amd64"
      sha256 "eff5e52772aa56d8a0a945be07c4c5aafd3aa6200c5a77bfb4a69f6ccea315e7"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.8.0/agent-compose-linux-arm64"
      sha256 "a06be2aeb395d349860150dae0156898d4bd32ce11cf98cb7a30621d36ea2f5e"
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
