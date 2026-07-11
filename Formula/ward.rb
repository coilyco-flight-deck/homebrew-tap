class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.619.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.619.0/ward-darwin-arm64"
      sha256 "a71a7bf7bfe11053ddbfdd490c49fd6668b1b6cba66af1a01ba4ccddfc1a6d19"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.619.0/ward-darwin-amd64"
      sha256 "465e0f382a850f7a7f8add420f394943d43d598bfd484f3c0295221e6682c80f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.619.0/ward-linux-arm64"
      sha256 "2cd335180f45d0336e6f62916c46c006918ca8bdf93a78d380a4cb5165c46c3e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.619.0/ward-linux-amd64"
      sha256 "540ec11d81dab4822c73b4baa3a394d4b036a972808800931e5df8c31ec2ad6d"
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
