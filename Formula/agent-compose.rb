class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.44.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.44.0/agent-compose-darwin-arm64"
      sha256 "fb58559b1fdaf027b098f5e5202ac98b711815299a6aee461e416605480233e0"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.44.0/agent-compose-linux-amd64"
      sha256 "bde66fd2615b7211834e42a4560673ebc30a36eedf07dd246262759087c0d713"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.44.0/agent-compose-linux-arm64"
      sha256 "dba808c13d49c7b99e9bfe50da086fab415fe23aba8dcddaacdd281056edc35e"
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
