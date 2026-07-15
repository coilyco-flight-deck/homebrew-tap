class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.709.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.709.0/ward-darwin-arm64"
      sha256 "cba75338d05479da683db51cd3f8c40d0cee06bb8c5eedc457b7fefd40c52451"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.709.0/ward-darwin-amd64"
      sha256 "07fadd4c5567e25a380a79a157dbab0d7efeddc303ce388977127694592bf5f9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.709.0/ward-linux-arm64"
      sha256 "775e5b7c9a97426695e2b60b798c00d4a4bfafc8efef89f6eb4e5fc8096610b1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.709.0/ward-linux-amd64"
      sha256 "e7dfbb7ed4174d2827d3af147f4172c2120e25752a7d7631092cab9d3ac30e41"
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
