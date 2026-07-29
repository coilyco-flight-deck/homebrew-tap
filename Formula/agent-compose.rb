class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.38.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.38.0/agent-compose-darwin-arm64"
      sha256 "fa78b52800f0a03388086341eb2f3ebc5a0c3aaefc3abb50c140961c943f7814"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.38.0/agent-compose-linux-amd64"
      sha256 "5969220bcf4f8405bb148ea7c1481f5fd89ec6394d45855a5142bb1db4bacde2"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.38.0/agent-compose-linux-arm64"
      sha256 "a4df15051059df704ab8f61c9ae3d89310d1f4c9989810824a6c7349166451d0"
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
