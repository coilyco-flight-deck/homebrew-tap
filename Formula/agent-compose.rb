class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.2.0/agent-compose-darwin-arm64"
      sha256 "ae74835566609dd54b06eb0281586a04d19b694830bb6e16b11737a48c3529b3"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.2.0/agent-compose-linux-amd64"
      sha256 "0758ee9bb58fd36b9001af2544b17a43926d49680e5befa033ba2bdadbdab324"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.2.0/agent-compose-linux-arm64"
      sha256 "709f068e475e746d22e6b356798142eb3a16f9cdd2136c7ec3b548fdd3259da4"
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
