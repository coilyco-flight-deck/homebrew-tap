class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.764.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.764.0/ward-darwin-arm64"
      sha256 "43ce7660ae89a0a3440f1a3df72038ccea2cf61e42ab3160838a7cdd9cf78a30"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.764.0/ward-darwin-amd64"
      sha256 "fbcc8ac640c4576c05fc5d590dd198bdc3547ebd37f0ca33084cc738fb237b54"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.764.0/ward-linux-arm64"
      sha256 "f2684a40f55f5b8478b363a5a497fd3ecd85c05b1312773ad4a64dcaa7e794f2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.764.0/ward-linux-amd64"
      sha256 "f3fe334aa11ae51a7cc497fce4929e5c01c1d652e495457065bd6f778e534866"
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
