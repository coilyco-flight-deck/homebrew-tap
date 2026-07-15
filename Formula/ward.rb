class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.713.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.713.0/ward-darwin-arm64"
      sha256 "e38ff1d93512bf823254ccf9ab41c15b1fd36dc510cdd61492b85dce6c4b52a8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.713.0/ward-darwin-amd64"
      sha256 "e3b2dce09276639f8530e5a7b99e9f4918fef92554aeac016e4937386a24568d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.713.0/ward-linux-arm64"
      sha256 "65ba6f4a38f19ab7341e99f77110090b0415c08b81b3129691c15c6b3b4083c0"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.713.0/ward-linux-amd64"
      sha256 "34517d1856d5befcd17dd92c25c7cf903dcafd0ea7e9867ddbf53e2b122fd891"
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
