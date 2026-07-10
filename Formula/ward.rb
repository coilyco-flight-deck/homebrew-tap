class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.591.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.591.0/ward-darwin-arm64"
      sha256 "1eca8631820733afae6388a2755d43104b2bfd1557e0c0d0004b98f4cd9e8743"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.591.0/ward-darwin-amd64"
      sha256 "f5b618e43e61e1fa46135e0175fd8050440b4aa35c94873f8e272135d883c17d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.591.0/ward-linux-arm64"
      sha256 "2f5dda8f126e53e6e66bc44de775c7fbaeefb8ca4fcaaaaa7f35b51d104a304a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.591.0/ward-linux-amd64"
      sha256 "6b526bd27dcc686633f7c3b3c85bd27a0d94b6215166f2a125239757745d1b04"
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
