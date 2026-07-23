class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.115.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.115.0/specgen-darwin-amd64"
      sha256 "541c62c1c17611053ab13eaeccd7d01c692328666b8fda047f5c8d63bdf38e99"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.115.0/specgen-darwin-arm64"
      sha256 "bcbe3b3dc84bfd4a33b732ecce7b258e92fbc1072336b3cd5840637bc02b6c6e"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.115.0/specgen-linux-amd64"
      sha256 "1d019970355db58e4d828b1b25cf609ea907f7773a6ba44e4e239fb7eb33a929"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.115.0/specgen-linux-arm64"
      sha256 "bc7889fe8a7cfccbc9faf51c511d7bcd36504350c3943e04e0f645fe763015ef"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
