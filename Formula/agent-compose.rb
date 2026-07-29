class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.34.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.34.0/agent-compose-darwin-arm64"
      sha256 "a4a2f67408fcebcedbfc2082441cdfce0edeb76f518743b2efca3db95ea51630"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.34.0/agent-compose-linux-amd64"
      sha256 "049242975402421a15a6ae1b1076d25c9871b693a7717b9a5180aa4401f89f5e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.34.0/agent-compose-linux-arm64"
      sha256 "ac665e418f6e5fef46d280dafea6981f5a0052626379745ac290a76919d6ca77"
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
