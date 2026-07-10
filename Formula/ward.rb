class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.600.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.600.0/ward-darwin-arm64"
      sha256 "a45a0d5fcc727541d267dee276cf11774aff0e6d244f77af1a552ad52e6820e2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.600.0/ward-darwin-amd64"
      sha256 "147fbd85a09ccd2f7b9b23f38c0d132a60416691606f73193def6533bd96ae13"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.600.0/ward-linux-arm64"
      sha256 "49d77f0813324afbe4334566726808274181e85b08401ebf96782b8240c6cc01"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.600.0/ward-linux-amd64"
      sha256 "f57a063b1dec0ecff2cf8cbd0891f524b6d633c1a469b426c47426c7a99dcc4e"
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
