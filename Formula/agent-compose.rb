class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.17.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.17.0/agent-compose-darwin-arm64"
      sha256 "d35e2fa6ec259651d2068ff787c2d782f686c1ded7cd3e3022c1c2b99a0afb73"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.17.0/agent-compose-linux-amd64"
      sha256 "6252228c170bf295fd5a76e65e333ac90364b5d83ce193df1a62dae8faa8b3c5"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.17.0/agent-compose-linux-arm64"
      sha256 "4fc2ed4d9cd7ab5cb06e54e71439b61a51422afbb7fe82a478cdca5da3dba309"
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
