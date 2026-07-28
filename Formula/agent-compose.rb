class AgentCompose < Formula
  desc "Context substrate for AOS, Ward, and native agent harnesses"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose"
  version "1.28.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.28.0/agent-compose-darwin-arm64"
      sha256 "5a1164aa2869fb43cd0e7840ba41abef9408d63404308f383f34b277b9a7d2e9"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.28.0/agent-compose-linux-amd64"
      sha256 "6da7a18263a58129dc67f27ab3090f592fe6a8b94edafbbcf972ed392ac3626a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agent-compose/releases/download/v1.28.0/agent-compose-linux-arm64"
      sha256 "a4c392c6f6765f349dc437ff01ffb53b34eabda080114632f55f2d9895f63f88"
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
