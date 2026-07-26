class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.121.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.121.0/specgen-darwin-amd64"
      sha256 "405e9571c5c1026fed715c87307ec7dd347338d597278b1861bd21409f94f90b"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.121.0/specgen-darwin-arm64"
      sha256 "44629e4f8853f3bf0e39cc7fccada72e53e72272992a7406017139c147c39c2d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.121.0/specgen-linux-amd64"
      sha256 "03c4bbd164f1cb21ed7e214b3d9a43b3a28797f4e4fe5c736cc336bd03d6a52e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.121.0/specgen-linux-arm64"
      sha256 "7f4286fbcf3ea79bbd480dc22ae28f0984d11ef23fa3d00edb47758d5c68f695"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
