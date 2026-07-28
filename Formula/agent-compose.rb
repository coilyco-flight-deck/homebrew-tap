class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.30.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.30.0/agent-compose-darwin-arm64"
      sha256 "bb3b9e9e8792b2214493eeae11528a7636028cbb35197101fee402c503f3039e"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.30.0/agent-compose-linux-amd64"
      sha256 "eca2414b26866c5707fe310b2177b3ab47aa45c1e4bd6e0078a2994757abd7d6"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.30.0/agent-compose-linux-arm64"
      sha256 "f40141a8883e71344da96082a70cd81bcb5b7f24616330aef1b13df1fb36dd5a"
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
