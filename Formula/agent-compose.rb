class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.33.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.33.0/agent-compose-darwin-arm64"
      sha256 "39829549c10d492dc3ece0011f2825e007798d7e85aaaaa47e52ecb161e3dbbe"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.33.0/agent-compose-linux-amd64"
      sha256 "0be5df12579eb10da3631bc32b493ad232f560bcb6127f3291d76f48a347d8b0"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.33.0/agent-compose-linux-arm64"
      sha256 "8f734d19b5355e46fa3b2797a0eeee501fed61e3446179e05a0fa7a6e815362c"
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
