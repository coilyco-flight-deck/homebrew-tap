class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.13.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.13.0/agent-compose-darwin-arm64"
      sha256 "2a6ab159025791c73a3d772339d2f07b91dcbf3b9ed98ae01e584cd19129ccce"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.13.0/agent-compose-linux-amd64"
      sha256 "b021e42e4a47d968fd1c2876a258132f1a7abb93dd5f4a8724f941906901689d"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.13.0/agent-compose-linux-arm64"
      sha256 "a0339a855f2b73347fcdd1f3abaef3cfa3c18a7545e01c2f0a54f9ff9a1abaee"
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
