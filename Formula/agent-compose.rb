class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.68.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.68.0/agent-compose-darwin-arm64"
      sha256 "3dfd6659e546c64f3c99b57d82d65c565df2cb26701e7415e3770fee26b0699d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.68.0/agent-compose-linux-amd64"
      sha256 "9b6b21cd0479f90ded60efc9bfc35d3aef5a1d06feeb5fce5588ddbf819c59f7"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.68.0/agent-compose-linux-arm64"
      sha256 "2d39d268c315e42c46e061173e843e025d1d8915c6912beb80577732bd88a875"
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
