class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.479.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.479.0/ward-darwin-arm64"
      sha256 "f66ae42e43551e6e5f6e21344ae763b644547c670f637d9c469d436f627b7c33"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.479.0/ward-darwin-amd64"
      sha256 "6c7fa2463b7f94b9022e0c6a3451e6db04600369b6043129d31ecfcdf6fb6a1a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.479.0/ward-linux-arm64"
      sha256 "0442bac407e92d2133374e97c1a3505a74d4d62c167da86df400f9f2c450b0da"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.479.0/ward-linux-amd64"
      sha256 "8200b3b00aa7f787da142933986c84f41704d14e663c6b8e4401fb5c11d1e1a4"
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
