class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.717.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.717.0/ward-darwin-arm64"
      sha256 "32d21d15ccddf37663f42904077d97aaa0239b61f702faba001258fb1b6ba1b4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.717.0/ward-darwin-amd64"
      sha256 "562b19adcbe88771008a0ec9f96b3d95a2b6323314b1a0e47d83bb05fc762723"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.717.0/ward-linux-arm64"
      sha256 "14fcebbfc22835d68a1e65868871f12bc93e1d3675a34697e0612063e0e3b8b7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.717.0/ward-linux-amd64"
      sha256 "036841645f5c7c7feea211c7cf8068da3b3ff3917f31a1970b2d07bfbc9dbe4b"
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
