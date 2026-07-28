class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.126.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.126.0/specgen-darwin-amd64"
      sha256 "7efa64d57b8282f9bcea3c4952ed203b101c7d91e2ffbb4c86daeea9c248dea8"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.126.0/specgen-darwin-arm64"
      sha256 "a2f6979b74a07acc782cb2290a1e3c582a5e6bef6c35fa9faa7fbda26b90e503"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.126.0/specgen-linux-amd64"
      sha256 "0239faf53a1a1ed138a7fb8a826538fcb4a8c36790bac7be353a0b520520f009"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.126.0/specgen-linux-arm64"
      sha256 "3d9dba576e75e78d7e751dde57b122af64d6c7fcec01d00a0c6de563453c8185"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
