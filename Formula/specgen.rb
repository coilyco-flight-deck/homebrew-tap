class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.113.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.113.0/specgen-darwin-amd64"
      sha256 "fcd636792a53f307284cb35360e59a2ff623e172196b0c13f806d882b0f44462"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.113.0/specgen-darwin-arm64"
      sha256 "2c1f7afddb9a6187c23033e80e2bd0871d7f4c3999a6725595c1ed46e85b7afb"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.113.0/specgen-linux-amd64"
      sha256 "2381e564ad80111797d0bf17478654c8f62e49056b047239106ef9abdd7b5fd2"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.113.0/specgen-linux-arm64"
      sha256 "d4d009005c04aae43c8162006ad8c5f414f5c0078050171d2de8bdd9050a6c24"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
