class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.112.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.112.0/specgen-darwin-amd64"
      sha256 "e1fdcb27352661ee50802ea7a7c7a19153cfe2712063d891ae667d4a8b27ac35"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.112.0/specgen-darwin-arm64"
      sha256 "ac1b22edce514f2a3cb4346b636c3403c961eeff9dc642e337fc54ba2cc12923"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.112.0/specgen-linux-amd64"
      sha256 "486117e2c5384e233256747cbe401daea0652cdf03d844a9d0d6ba9120f0eb4a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.112.0/specgen-linux-arm64"
      sha256 "e5ea38dbf232cd09e3a77cb815264001534758428aabf173e0ac74582f099019"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
