class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.10.0/agent-compose-darwin-arm64"
      sha256 "4bfe819a77cee327bcac1c23e5b9078d657537a496a7161b459334cfcb1952b3"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.10.0/agent-compose-linux-amd64"
      sha256 "380a3a54d73859e04f3f0273818e4a38af03475eae5e98dd53acb319e57e4cc6"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.10.0/agent-compose-linux-arm64"
      sha256 "1d2684818ddd933667c310dd5e72e85f842df4c3a9b1e991cd7e7335ea084aaf"
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
