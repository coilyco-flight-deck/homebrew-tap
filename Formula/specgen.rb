class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.123.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.123.0/specgen-darwin-amd64"
      sha256 "1510d151df222deb4ae898e03898ee3975fd64192f8a7ca6e62333a3bed5e7c6"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.123.0/specgen-darwin-arm64"
      sha256 "35e4dbc900a27da097dc472235e07d05ea808657d2f777ce2b079cea6e6e0524"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.123.0/specgen-linux-amd64"
      sha256 "333925a5d149e29790f1ba2adfcdd7a7ccd3a2c94d9cdc4c90bf1b103c8b3b6c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.123.0/specgen-linux-arm64"
      sha256 "43dcb726ffde9b7cddb7b3bad84ad7bd4dfec3a8f0e79e436ae181d76d5a3bb6"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
