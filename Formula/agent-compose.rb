class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.9.0/agent-compose-darwin-arm64"
      sha256 "330c750e7e767b7a37fe2c38af00ff2adf076c8ea7df57bc889d6fb65e037026"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.9.0/agent-compose-linux-amd64"
      sha256 "2c992da614a32019223e0cbd69609ce7a8cfca0cc17766cf283d24ffb36d47d3"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.9.0/agent-compose-linux-arm64"
      sha256 "26a5b2615b04a598ffc06492e0e58a79cdda52fb9f92666193cad6bfe688eb55"
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
