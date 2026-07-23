class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.114.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.114.0/specgen-darwin-amd64"
      sha256 "8ca3905bcd4f4e09c8575895579ef6b977f45dd0efb533780ec28246d87a198a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.114.0/specgen-darwin-arm64"
      sha256 "8f318e19fb2d535068ca352b3d50fd4f0eaf1063bbf143a2179006ef19cab583"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.114.0/specgen-linux-amd64"
      sha256 "4dd74679ba74f05169733a5e9810c7e7568f14ae0a6a923e21dc0b7b1663a3fb"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.114.0/specgen-linux-arm64"
      sha256 "0db8c4979bcd0aaaee4f221e481cea25593538afa13e7182b97dbe8949329bb8"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
