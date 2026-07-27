class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.62.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.62.0/agent-compose-darwin-arm64"
      sha256 "b069f930e5fe16a65eee04b7a16ec2471afe69f41329c5e3da66d4ac4dc65e5a"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.62.0/agent-compose-linux-amd64"
      sha256 "2b6cd73f0a6f62a0e5870cc3fe5195ca9a15485ceecbb91564147c9b3d84e8ff"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.62.0/agent-compose-linux-arm64"
      sha256 "5a1b37b201cf8b14e5ee4249200ba12ad57187105853ce9139ab862aa54b8478"
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
