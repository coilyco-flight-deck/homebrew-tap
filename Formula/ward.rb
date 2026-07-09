class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.471.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.471.0/ward-darwin-arm64"
      sha256 "fc6dde40225ef9a0b798375500efb270a87ca65454dc3631d5eff737770a8584"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.471.0/ward-darwin-amd64"
      sha256 "84c71215c7dd21d1a6fb5ff72c93a15f4be76499061f27e87a99fd50415fd5ad"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.471.0/ward-linux-arm64"
      sha256 "302e7bd704550c0bb1427f6f43a16f50a4679e93611cb03ed37f21ad68fce8bf"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.471.0/ward-linux-amd64"
      sha256 "1dc2f552916fde7d40fc691144fe0694cb5e3b0eea3b8eb7db44979de2d382f7"
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
