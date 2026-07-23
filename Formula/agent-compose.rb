class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.19.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.19.0/agent-compose-darwin-arm64"
      sha256 "cee6d798018e921cca71bc73282f6fde2113400d8c3925360623f7640b969789"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.19.0/agent-compose-linux-amd64"
      sha256 "2dc999031bee59be168cdc6d8cbbb7a89d104035286049db00cccf86022b6799"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.19.0/agent-compose-linux-arm64"
      sha256 "f0c036e9c787ec73b21a61e99100d9f351470beaa91ed64628a683f7f2a081ae"
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
