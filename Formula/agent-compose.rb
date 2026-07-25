class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.54.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.54.0/agent-compose-darwin-arm64"
      sha256 "37cb41763874673d9a30ccba8dba0b19f3a9cc0be382fa0e819f57634d49a767"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.54.0/agent-compose-linux-amd64"
      sha256 "a4cbcd946944d6c944d5a18f6003ae007751e5f6d0d1f0a5909507000204b320"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.54.0/agent-compose-linux-arm64"
      sha256 "0da956030cf2a92c059aac0db10423a29b3b337e920ea4dfefb1789618ba5c1f"
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
