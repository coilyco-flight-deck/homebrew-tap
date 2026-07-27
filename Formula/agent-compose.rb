class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.8.0/agent-compose-darwin-arm64"
      sha256 "e2a93e735e65db82d623e871c0ec5b1346dc61c2ba95e842e97bea716f941011"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.8.0/agent-compose-linux-amd64"
      sha256 "87c67b0b57de2c6b01f789ddf2fbd9a1e1f087ab5c14920997bb86d164c78cac"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.8.0/agent-compose-linux-arm64"
      sha256 "b15bc87fd540dbbe3d12daef9a501464001c4bf64d24a70ee5dd3b2b50bdbc01"
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
