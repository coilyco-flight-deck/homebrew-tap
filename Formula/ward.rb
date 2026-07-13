class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.652.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.652.0/ward-darwin-arm64"
      sha256 "ba05cfebbc4038e70cc1ff287ff881312e8d7056669493651a99ee6a83cc93a5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.652.0/ward-darwin-amd64"
      sha256 "e9e002dcbae78cf2a5ee2d7724e923e3052c0525b941584b77c5f37a50318a4e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.652.0/ward-linux-arm64"
      sha256 "b5d1f84335d9b22b0d8ed5838d7b8389da819ce72875a325c2b5d757582e07e2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.652.0/ward-linux-amd64"
      sha256 "25054f193b0b667f5bdfaf4e75ae7e0632407afc8031c301bb576547a97770f4"
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
