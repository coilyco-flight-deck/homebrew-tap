class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.626.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.626.0/ward-darwin-arm64"
      sha256 "d9e7caf1280b9d15de759fdafdf0ef884a9ad5750a9b978259cac7414026c6e2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.626.0/ward-darwin-amd64"
      sha256 "7d1ca623607351d2392af42f3f2624bf03d112d01994aeeb8f09112e490b8ad4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.626.0/ward-linux-arm64"
      sha256 "db4847c8a94b0c5ec3db60fde78f539c361e22ddac7c4f1684b401c7216bd768"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.626.0/ward-linux-amd64"
      sha256 "be479f11e7cc2c01b093c203f6467a4f0e7ae8249d1921bd8f0036a921cecc44"
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
