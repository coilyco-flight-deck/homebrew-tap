class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.539.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.539.0/ward-darwin-arm64"
      sha256 "b9875890ee4c0b4c2c024030beba3292bbd0e8045aef66883035ba6b07df1e45"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.539.0/ward-darwin-amd64"
      sha256 "5ee5b7c37d7cfbce4c3aa3ae23489382969503af1d948801f326d741577d2f79"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.539.0/ward-linux-arm64"
      sha256 "0a31370c1274351ea4425d52ddb27ab58e864c5b00c9455e522e9458b63879f3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.539.0/ward-linux-amd64"
      sha256 "8f96d31e25a7fdc2c138dab349123d68b9d828100bf685ed5fb518ebe5541277"
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
