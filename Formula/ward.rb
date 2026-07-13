class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.658.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.658.0/ward-darwin-arm64"
      sha256 "0a5ea7561594c77a95abe1d3182738ab5ba039ad5784c2f799ca928d8cc955e0"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.658.0/ward-darwin-amd64"
      sha256 "fdc174c17309efa6f879e651feec003e738caf2e6b07d85f3915aad38bdda01c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.658.0/ward-linux-arm64"
      sha256 "05e5f270bedf190ef8e3c30cda386e8014f27cedd4372318811ac7303befe3ef"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.658.0/ward-linux-amd64"
      sha256 "880aecfcea252d1fd014959c1c27b700d41ed2c8e37b082896ed242c1f7265a5"
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
