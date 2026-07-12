class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.628.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.628.0/ward-darwin-arm64"
      sha256 "2ed5c0fa78df3d8a71bfa9adb6980e0ec8481412696f28185220d747f0f1e879"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.628.0/ward-darwin-amd64"
      sha256 "f32628eb1bb9954564b4c02fe60a2eff6ec555de110aa5efb4f34320608d3440"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.628.0/ward-linux-arm64"
      sha256 "cc194e33c70c8892893336bd26f2ab03f16af415612fc90645fa438714cdc0e7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.628.0/ward-linux-amd64"
      sha256 "2c5263bdafb6c2c617eb3cd7d359aff410dd6cea58f91148bfcf69bae30b7297"
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
