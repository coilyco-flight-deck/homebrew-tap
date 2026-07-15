class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.727.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.727.0/ward-darwin-arm64"
      sha256 "3927be19ca40db237ac8b78c55402b095371cc2a1b62d2bc407e77f854a6a4b1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.727.0/ward-darwin-amd64"
      sha256 "8666c0b5eefd73268f71ee7eb8e5300d5369bddd28cc2f1bdc2e253474576d21"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.727.0/ward-linux-arm64"
      sha256 "67c6026c170c31dadcdd5659adc9e678bbd6868fd7cad8a0c6d23e55f5c91009"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.727.0/ward-linux-amd64"
      sha256 "8bdeb26e555d7e2d04eb4158c5faa83a5132ad64c2306d757e6c521227106776"
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
