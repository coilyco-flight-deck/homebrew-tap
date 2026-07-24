class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.118.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.118.0/specgen-darwin-amd64"
      sha256 "95eeecf08b0a23682292f26ebb6cb1196319a92bcedec9d1a93e2fd3f7af6734"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.118.0/specgen-darwin-arm64"
      sha256 "802b057b38a8cc2fa3ef287a5a1a44cd5294d7175ef0699694b48b3d6ed12835"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.118.0/specgen-linux-amd64"
      sha256 "0f710356087006475006d55bfc75fedcd140e008039ec59c6dd9c776ab8ea149"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.118.0/specgen-linux-arm64"
      sha256 "41fb56b9f82d3c4e1eaeab3ba490d0b5776e306080ec64cb1cd22b6af99bc71b"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
