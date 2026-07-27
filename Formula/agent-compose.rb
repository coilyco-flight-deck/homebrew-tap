class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.67.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.67.0/agent-compose-darwin-arm64"
      sha256 "72a412516711b290718d609c4218128def84f76c7a9614b6f83784223583828d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.67.0/agent-compose-linux-amd64"
      sha256 "eb252e130266629c2a3a57230f56e28dabe91c2072b0f7d0d757d9e4d6cc1e6c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.67.0/agent-compose-linux-arm64"
      sha256 "3243e5117d1a9e81c1834ceebf175d8b4577406bcfcb83fee271943435d276ff"
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
