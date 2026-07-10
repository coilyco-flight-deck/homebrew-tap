class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.597.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.597.0/ward-darwin-arm64"
      sha256 "ab9d38171b1f5bc7ec591d11e161030dc2d8faec39d822b6e85e010be8610f14"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.597.0/ward-darwin-amd64"
      sha256 "9ce03982639c18e97efbac0e705731609ad8e38ff848fa3e151b7a942f515dd8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.597.0/ward-linux-arm64"
      sha256 "59a558d0a6c849375f5f708bc0961a228526318f310a44c8d1d6c0b215cbb151"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.597.0/ward-linux-amd64"
      sha256 "7bdfbe94bae8cb89b5387d8d1359f7e0f21cbbb90f8fea739acf80314976c2fb"
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
