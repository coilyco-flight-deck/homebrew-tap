class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.639.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.639.0/ward-darwin-arm64"
      sha256 "81b7caa1e3b87b27d3ab065734a842b171841e088902b336be36c6daacd3c671"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.639.0/ward-darwin-amd64"
      sha256 "64c2760de28991159ca3b246d20887ecbfea865d3c4cb7d0dd61b11352dd0a8b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.639.0/ward-linux-arm64"
      sha256 "7f05ec9b064d2d864b655f1b66e6929ef57b8a2eace97033ca9319827416dcf3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.639.0/ward-linux-amd64"
      sha256 "d6ddfc62d81187bebb74bb5439a47e11a7954075bab3fa623cdf1ecc99cfc057"
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
