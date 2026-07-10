class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.588.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.588.0/ward-darwin-arm64"
      sha256 "2bad4e22df24de790bf3ccbee335c66a447c3444e54afb311d6ad3b68f5155a9"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.588.0/ward-darwin-amd64"
      sha256 "a03b1da9023bf59b03a9345e21baaef6eafe4c232e9b64ead443e035098f711a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.588.0/ward-linux-arm64"
      sha256 "3c8dca3456829bf1fdf2bdd5b231ed171dd81dbf8a4d78e2b6351d2e627b7e53"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.588.0/ward-linux-amd64"
      sha256 "e20591ed899269b54d5bc52048cf7580d95053c1c4479523565c64ce2afe5082"
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
