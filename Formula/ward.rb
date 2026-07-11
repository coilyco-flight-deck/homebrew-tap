class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.625.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.625.0/ward-darwin-arm64"
      sha256 "0376f0b8760c582e59fc3b1fbe75bbb0daebc317868a9a15e77f445fcd810d69"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.625.0/ward-darwin-amd64"
      sha256 "500a9ec2fc2ac79cf20305f0b25da0c0776532871395387e4cb09ea487b1102c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.625.0/ward-linux-arm64"
      sha256 "b531cb18f50f57d0cdea74410e557e1d4a03aa75656d6a27ae74045f9b1a03be"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.625.0/ward-linux-amd64"
      sha256 "c9a0c21554d4921f8da21278382aba64352d4d271813ac16e3dd2e50eda2b6a8"
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
