class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.20.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.20.0/agent-compose-darwin-arm64"
      sha256 "a381a6f32270aa0cb2dedcdaceed05b403f7234323480df1860222c3e7ee158b"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.20.0/agent-compose-linux-amd64"
      sha256 "3308bd62bcbc5c2db18ff1eddb72efe49ae54ac92883532e7fe3430a7ead43ed"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.20.0/agent-compose-linux-arm64"
      sha256 "b9e87d986cb942d70e780f129f633d329c66ce6f8d31c24d410e2edaaf07c50f"
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
