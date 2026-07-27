class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.10.0/agent-compose-darwin-arm64"
      sha256 "877f393e47cc3eacc434a55c84d312819c854b1db8095a81b2f8464f11e34abd"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.10.0/agent-compose-linux-amd64"
      sha256 "14aec39aa848a1cd4deb6cdac88ef31b5c787594f38b7da542525751e047a71e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.10.0/agent-compose-linux-arm64"
      sha256 "5a34340d3650972d1c0fd0b22c7193bb75657f2b454c48f0bbe44306f481efa1"
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
