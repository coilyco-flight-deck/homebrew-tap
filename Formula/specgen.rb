class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.125.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.125.0/specgen-darwin-amd64"
      sha256 "807d0def573f29f929903226a66a4bdeb694383c662642e8cd8e8ce6645ff293"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.125.0/specgen-darwin-arm64"
      sha256 "6acf3a34aa5883635a4c9acf667f950868db4c4d9b85adf48a644f80ee2a150d"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.125.0/specgen-linux-amd64"
      sha256 "55d47a3bae3eb6b632493bbb76e2e94d9b93d0c06bf3777ecb6af9fb4a996bbd"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.125.0/specgen-linux-arm64"
      sha256 "d3f4c862a31377eb4ac96e4ce5f689e54cd05803f76c08a98ffa5cd9d7c2f953"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
