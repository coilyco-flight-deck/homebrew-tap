class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.42.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.42.0/agent-compose-darwin-arm64"
      sha256 "b0f2c143f45c0de54a76b9fa7d359747532f2db8f3b4197c844ac8ff7ceeb6c7"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.42.0/agent-compose-linux-amd64"
      sha256 "cf9e4e619964002a6cd9d4c36d34ed5c27df4bbceb26b03b580cc309e7664c00"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.42.0/agent-compose-linux-arm64"
      sha256 "acd90e18a26ba3b7676f8f70ff276adb61a512c443f653aa612b202238b889e1"
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
