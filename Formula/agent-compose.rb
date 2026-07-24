class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.39.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.39.0/agent-compose-darwin-arm64"
      sha256 "b2f9da727d9d2bff9305ddb4bd24774d8509ad3a902a37367bb9faf77fc2066d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.39.0/agent-compose-linux-amd64"
      sha256 "369eb9121d3ef151640dd6ab8d113779d7af77468496c35e9177e36f442236a2"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.39.0/agent-compose-linux-arm64"
      sha256 "e32808c589dc8cf6d0eb6bc3727acbb875429fd995e3320f984c5a4d69b44b47"
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
