class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.461.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.461.0/ward-darwin-arm64"
      sha256 "762694b8dcdd3e9a6bd7e8437ab104e396224bc898aa8d89bebc433e05f029e5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.461.0/ward-darwin-amd64"
      sha256 "5fc8c0e05b1bb4e7efe83bb2c3c4be0793801f7b49854637b9ec6475be75d6e5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.461.0/ward-linux-arm64"
      sha256 "6d1d0201362b37d584a3b2bdfe74a93d017d217378007b6aa741c443aee9f49b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.461.0/ward-linux-amd64"
      sha256 "dfcc844f331053310cc176415b9101df6fc440d43097fef722cbd51abb32eda0"
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
