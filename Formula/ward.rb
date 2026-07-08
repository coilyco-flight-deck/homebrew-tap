class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.452.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.452.0/ward-darwin-arm64"
      sha256 "bcf83a555f4013b748393b122b880916570ff22d1528c4a6784d7826db67a80a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.452.0/ward-darwin-amd64"
      sha256 "94008effdb6e4bd1ffcfe6cfc670d2f360e8d9ff825f85e2c3ccad3033c82fb1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.452.0/ward-linux-arm64"
      sha256 "a29a112ecc57db111ac686adf47f5316cea8d50d4674715421cade8f17cab71a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.452.0/ward-linux-amd64"
      sha256 "eb1e5c6db4c64052bcf8c8e9111066e6ec3cbeaf74ea6637d3b8be77b3b1f2b9"
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
