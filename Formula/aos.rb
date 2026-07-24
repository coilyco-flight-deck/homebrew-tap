class Aos < Formula
  desc "Standalone composed-agent container launcher for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.46.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.46.0/aos-darwin-arm64"
      sha256 "4cdca1061deac36f6177f40e5b56ef83c24b45dfac98a8e1a6afc1e7f21d4a5f"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.46.0/aos-linux-amd64"
      sha256 "6416fe070d479102cf618f771096447e4c0be66522a4c181956b6a4c69834a46"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.46.0/aos-linux-arm64"
      sha256 "48fd96ca49fe2ee54fbda32214c1bb67e79d8873e110f639fdd49f36cd8ba439"
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
  end
end
