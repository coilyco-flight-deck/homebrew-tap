class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.119.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.119.0/specgen-darwin-amd64"
      sha256 "2aed3a225403d313be20969286d0065014aa1730dedc2b5d6bfbcc5fa54412d4"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.119.0/specgen-darwin-arm64"
      sha256 "4ea437f7e8768ed766c8eb9acde8928a8a2b97926a99e799cfe4b8d9f360d969"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.119.0/specgen-linux-amd64"
      sha256 "68bdfa9b7b04a13ce1fe633e98674c485593953af396f0ce639b4aae68cf97d0"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.119.0/specgen-linux-arm64"
      sha256 "7a4979177edeab0fbe49b0aebfc12a0ac63e071f2aa9e88e34bd770239eecf2f"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
