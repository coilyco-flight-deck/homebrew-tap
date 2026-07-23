class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "0.13.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.13.0/agent-compose-darwin-arm64"
      sha256 "16ba01e587e50d68fd9662d512e90494010b02b3a5d0c412c05daae4396e9518"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.13.0/agent-compose-linux-amd64"
      sha256 "e8cf58a2791489eb0519816faed2f5ce15e140ac9d45d8982df16c496c206b4d"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v0.13.0/agent-compose-linux-arm64"
      sha256 "af0a41ab7f5fd01d440693bc5c0ababd54016d5ca529602ed49d42514766611f"
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
