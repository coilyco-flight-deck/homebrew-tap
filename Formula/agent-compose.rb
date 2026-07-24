class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.24.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.24.0/agent-compose-darwin-arm64"
      sha256 "2acb563efcebcb66ca334b903f814855bf97d3957593dad8a1f54d0bfac8ef0e"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.24.0/agent-compose-linux-amd64"
      sha256 "09fe88aa3a54228032f727f0980336163ad7cf19b4eb18612da1683b7f3efd73"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.24.0/agent-compose-linux-arm64"
      sha256 "66480b6637bd1ec9bc3ece977e6f54cb650f8b761aa5658c5b40e28a5003bd2e"
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
