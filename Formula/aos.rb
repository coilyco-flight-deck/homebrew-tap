class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.54.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.54.0/aos-darwin-arm64"
      sha256 "382d182277a4e0e90393134c7043b0ba726e9e2bc45260781cbd2f5f66195ef4"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.54.0/aos-linux-amd64"
      sha256 "ccba1af0780a3dd7e6eba78df0c83a351296923a81c2bebc19be6772b0974160"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.54.0/aos-linux-arm64"
      sha256 "7a054c0883f240c9d4860d3642842e47929a8c4988635253d0470345fc4db105"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
