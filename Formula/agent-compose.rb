class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.14.0/agent-compose-darwin-arm64"
      sha256 "13b54cd602e679fb2f0a6ef43ce72e1d1c6821aec10916157fe8a724912cdd3f"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.14.0/agent-compose-linux-amd64"
      sha256 "a5c4f260f46272427ae9f2387d2405c5bbe3716a123f71905a0f84a700f279f4"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.14.0/agent-compose-linux-arm64"
      sha256 "bc5891e5bb8d5894a4276977eaea88dfdaf43d43e003a888a723999efefa2eac"
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
