class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.42.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.42.0/agent-compose-darwin-arm64"
      sha256 "a864b3ac307172d5cb605365252299c14226a4586f8aff48276c93ca45cd8c56"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.42.0/agent-compose-linux-amd64"
      sha256 "a73d91e49facae20300575836fcd226769d0d0d3a5e4695f169d88db4e410131"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.42.0/agent-compose-linux-arm64"
      sha256 "4e9456b382f42ff1e2436bea3aef60997d03284e0c00ca6136a3d9b046ef6377"
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
