class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.754.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.754.0/ward-darwin-arm64"
      sha256 "66a8d0cf002e718b77400a84a39f92ec2cef294d06e6f08992cacc40c2c8fffc"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.754.0/ward-darwin-amd64"
      sha256 "dc3007c3a402d28b682bf10d289fb9aaeb10489a0e6aa98a28010ce6f95dca6b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.754.0/ward-linux-arm64"
      sha256 "d95c5ca4339a841d4cb5a688105ff750d723eee5bd5d55659b3f8da9327b0d04"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.754.0/ward-linux-amd64"
      sha256 "1b0136e3e75d012a0dcea0034113acae94228fa8b33d8c967587fd671f8613a1"
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
