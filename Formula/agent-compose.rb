class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.49.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.49.0/agent-compose-darwin-arm64"
      sha256 "a5fded5af4a08318e95e08d826999bbb772893e414334280abd5419300fe2e9d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.49.0/agent-compose-linux-amd64"
      sha256 "aad8708a29ee45b2dbb128d9e5e9c80fe6f1368fb4173ab73fd0cd90f3612e5f"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.49.0/agent-compose-linux-arm64"
      sha256 "ca7684f256eab8ace792ce378ea7db8de0edc66a322128b8264b12f4b8f1fec8"
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
