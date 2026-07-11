class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.623.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.623.0/ward-darwin-arm64"
      sha256 "4d225984e7afa25f9e145b4e964549380061d1a0827c86233b52f89a0676c65d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.623.0/ward-darwin-amd64"
      sha256 "2683cf11ffbdd2796fe17ac9bf516743cf8aa15d043a44b339c40e3238ef1e25"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.623.0/ward-linux-arm64"
      sha256 "eb4801cdeabb77f3e37b5f9a46552ad25e895b358b15de9191520c98d5791994"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.623.0/ward-linux-amd64"
      sha256 "f4c5c1144bb7f64dd93d40271fb1cf6f95c7a1c6ce4bd8566d2d0c23027fb50e"
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
