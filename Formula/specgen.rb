class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.116.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.116.0/specgen-darwin-amd64"
      sha256 "b2f234061db039c58061cdf31742433bda53df2c5c0d0a4942e85b89f20c3f61"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.116.0/specgen-darwin-arm64"
      sha256 "394f2bb359ba9ec23dc6c7b4dc1ba8214c0f9bfb3101789696ba5ebe086638f6"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.116.0/specgen-linux-amd64"
      sha256 "be1d91522df2bccf7bcf8a0aeeb390045661a662c8444d69caf2a5f8cbeda06c"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.116.0/specgen-linux-arm64"
      sha256 "01a1cd0082118755166eff8c4e0bf2634f911b406557a5a774d391a16f2d867d"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
