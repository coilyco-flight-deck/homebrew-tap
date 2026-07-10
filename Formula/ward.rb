class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.549.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.549.0/ward-darwin-arm64"
      sha256 "49e576c59d0a1b0ccc364485b239b048b58c925ea2e9d1858909ad965808286f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.549.0/ward-darwin-amd64"
      sha256 "0d58eb61ad8d51d058a82cb5f3301282cdc6a86a2a55c1f9996f5e304c023f3d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.549.0/ward-linux-arm64"
      sha256 "b28aa721f537ac8c25de87ea2c2ff10f0683f49f59739fb5ab071e1b3194f387"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.549.0/ward-linux-amd64"
      sha256 "174ad54360286b5bfebf8b1c97d1b93c648d09fb62991a39f23d6bd1698ceaae"
    end
  end

  def install
    asset =
      if OS.mac?
        Hardware::CPU.arm? ? "ward-darwin-arm64" : "ward-darwin-amd64"
      else
        Hardware::CPU.arm? ? "ward-linux-arm64" : "ward-linux-amd64"
      end

    chmod 0555, asset
    bin.install asset => "ward"

    bin.install_symlink "ward" => "warded"

  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
