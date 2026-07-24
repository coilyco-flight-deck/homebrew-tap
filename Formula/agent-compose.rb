class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.33.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.33.0/agent-compose-darwin-arm64"
      sha256 "192f736eab48a190c33e067d4aabac380b83de86b1ce71fba3c8be1294ecb753"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.33.0/agent-compose-linux-amd64"
      sha256 "9489c93887364771f3f55b6d075771c77bbb31e9b6fd185a96ff5421e498ebf1"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.33.0/agent-compose-linux-arm64"
      sha256 "93761977d1ee36b66596c1b4c88238a55cd6ffef6a42283dddc12f18beaf8553"
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
