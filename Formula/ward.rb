class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.580.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.580.0/ward-darwin-arm64"
      sha256 "ccce6d4ed38b878a17c11bbdd19e8bbcb8850bb714f0b870c5260625a5a41dce"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.580.0/ward-darwin-amd64"
      sha256 "de7e1d7d05d0e2ba49a8b28497b2634117e02d27c280caf9b2e6e51b8c2df1b0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.580.0/ward-linux-arm64"
      sha256 "270fcebbc6736474b669149603cc9a5ac21fa2d816fa0a8ace31dd82ebac0242"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.580.0/ward-linux-amd64"
      sha256 "0b71fe3415385242332d98906e7bfb02ff2a3c23d1bf23f46e7d2d947e3fd2e4"
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
