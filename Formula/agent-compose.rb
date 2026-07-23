class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.14.0/agent-compose-darwin-arm64"
      sha256 "337248e24ea537c2efbe6ddb60e04567db3b51f33b8569ba42a95a9dc763a8d3"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.14.0/agent-compose-linux-amd64"
      sha256 "608349de635f6d6dac639915ca55a248334498bf6e3447ca5b7bef84c1051457"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.14.0/agent-compose-linux-arm64"
      sha256 "c7b79e1a41ecea49df21e961fb6c31489a4eaba5c2f7c2c75705fab19880f55d"
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
