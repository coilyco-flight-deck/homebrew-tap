class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.124.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.124.0/specgen-darwin-amd64"
      sha256 "da2baee601cb302bfd8678c29f257878135aa802ddd42866bd7f9029d1c6987d"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.124.0/specgen-darwin-arm64"
      sha256 "4cc2c3959d1815e8299e9a9eb71352f3cfe1094953e55bc9d20641f1e303c7b8"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.124.0/specgen-linux-amd64"
      sha256 "6a3b178ad5bc04be078078862faebcef52cc9ffc06c2d269015d4eb8b99f84cf"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.124.0/specgen-linux-arm64"
      sha256 "7e690f43a888e44f0a12e6a626e55e2814fd2c16de36663f4bc9d4abf556ea18"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
