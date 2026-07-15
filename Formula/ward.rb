class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.744.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.744.0/ward-darwin-arm64"
      sha256 "39190c1746b0665f870f09cee2153d24240d361f7e5b63fcafb5a61b94aa2f2d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.744.0/ward-darwin-amd64"
      sha256 "0ccd43ce70761762b3fbf7951af5e42e648660ed99199a92cc49663ed627824e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.744.0/ward-linux-arm64"
      sha256 "c5e103319ed6b2bd4e1c950d268746cfb4f362adbefe80daf8d8452782c683fe"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.744.0/ward-linux-amd64"
      sha256 "4f555a41a2cff8bfc5856416f3248645e925ecfacfb1ed036a153cc9b0d883f1"
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
