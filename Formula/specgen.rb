class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.120.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.120.0/specgen-darwin-amd64"
      sha256 "ea654689c00715f51d2ae77a30c7c9a93e42a1c3633cd0bf6813790c2dab2cea"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.120.0/specgen-darwin-arm64"
      sha256 "8a3ee99c1612bf765b3276c1d818af925ddd36c676dfe21fec58f2cf13f0c375"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.120.0/specgen-linux-amd64"
      sha256 "cbfc43a3d98a0e5cfd20e40ac7a26f15f691de49530bcc29c5b6f5abce7a8372"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.120.0/specgen-linux-arm64"
      sha256 "068e66e1869aaf1aa2dac78cb2acab6e1fd91d3ecd7e882af6053045a4a26071"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
