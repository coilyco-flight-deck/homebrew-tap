class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.752.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.752.0/ward-darwin-arm64"
      sha256 "bc67e3b151ebb8b66152953c6466d27a18880e66b13ac24bf8afee0cd6acbb58"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.752.0/ward-darwin-amd64"
      sha256 "37fe14475fa13260ec52a737b2af41c8232fdcd5dcd629680e168a3e64be703e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.752.0/ward-linux-arm64"
      sha256 "d1d2a455a0e70b7b5b0fcbc7c3e118e3cddbf652d099aaee4a955a38207fb2fd"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.752.0/ward-linux-amd64"
      sha256 "2d8fff9e4b5bb57f03939de63de354e4b69db29f4069278670ccf55825a9dcca"
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
