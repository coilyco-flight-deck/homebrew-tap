class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.117.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.117.0/specgen-darwin-amd64"
      sha256 "d5636beb82639c0b30b6227e99c994d272fa5663363eb94791764bdf9d805b89"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.117.0/specgen-darwin-arm64"
      sha256 "cee3df341f28f8def3edb0018b7095fcea3363bb58e1cdf870b16ee81d793179"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.117.0/specgen-linux-amd64"
      sha256 "898568e6c946ea26b2fd4077df2fca7fbd010d8b7a4fc292023e4f053b498db8"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.117.0/specgen-linux-arm64"
      sha256 "5086997405a6b0dbc646c18f2e77865818e231b6c89a7037b4fa5298953e7a96"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
