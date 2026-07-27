class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.21.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.21.0/agent-compose-darwin-arm64"
      sha256 "da38f7fa338c41514c2cbaf25ff9af1c2ce8456246828ac5706af3f152f0251d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.21.0/agent-compose-linux-amd64"
      sha256 "f8d469f4177cd446070e673ec0067abcf84b665bc80e1134e11d1c6cefcd4893"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.21.0/agent-compose-linux-arm64"
      sha256 "c32e27f0efecb0dfaa4e65e0aeec52a72751ad0b021fe0f3d7dd6a6be1f4ecde"
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
