class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.578.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.578.0/ward-darwin-arm64"
      sha256 "4bd3a3c6c2c08bbe4afda71f8174d2b0ccc1d537fee7d37dcf5729c9f53ad7ae"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.578.0/ward-darwin-amd64"
      sha256 "2b59295982687bee9d062b5d3e66dab7cd28d501f79a5d2ecb1bb774978364ce"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.578.0/ward-linux-arm64"
      sha256 "68e374a27ba72ad9c87bc884e49d7a66057a56bebb3edbd7811ae4eb32335b2d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.578.0/ward-linux-amd64"
      sha256 "1026c08e0068d079f94e826ebe284934a5ebf042d324cd1170c3f18fdb9d558a"
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
