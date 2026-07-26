class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.122.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.122.0/specgen-darwin-amd64"
      sha256 "7daac7ce5106c18db8804509fcc40d3f8160dc4bead3d88d57c4027d8aeb3b42"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.122.0/specgen-darwin-arm64"
      sha256 "b92083f8e02e7c401f65075b2381ab6d38a984f4cc838f28faf0314b41d8da23"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.122.0/specgen-linux-amd64"
      sha256 "b72fb6551349cdeefe6d2b5f3ca7ceea414f8b5ecd01cd0734b9de95c408108f"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.122.0/specgen-linux-arm64"
      sha256 "f85293bdff403e5af89fea53a5eeba110cf6aabe2da3dc99d4495999417dea23"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
