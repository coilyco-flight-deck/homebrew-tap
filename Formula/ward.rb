class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.762.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.762.0/ward-darwin-arm64"
      sha256 "c1b09c7b33724bedc2cd010e2f501bcdf13a96df5d276cdf0048ab2948b430e4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.762.0/ward-darwin-amd64"
      sha256 "1eb9dc2c2a735c88e8e014e79045e1f86cd357e3479f18cfbd64a67d520ee52f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.762.0/ward-linux-arm64"
      sha256 "cf3863b87856f5da13f96f1c6ce3b1dd48d8d86d557693e251ba0af75d901e9a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.762.0/ward-linux-amd64"
      sha256 "3f4c27562c3ebdfa92ee0d30e46d7d7212182b8d9680d0ca95c2a4f4427ba7dd"
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
