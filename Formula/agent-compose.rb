class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.5.0/agent-compose-darwin-arm64"
      sha256 "72f2fb7eff982460417f82790d42561cc0f5b1ba639cb25ac6415f54302b4218"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.5.0/agent-compose-linux-amd64"
      sha256 "fa27e16a645abf8625760639c9258a81fec67fb1c9bf6e3b4120897a84aa54b3"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.5.0/agent-compose-linux-arm64"
      sha256 "f06ee80231284ee73ac0a278e289468839d74c424845e488fb55ecbef52a2c4a"
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
