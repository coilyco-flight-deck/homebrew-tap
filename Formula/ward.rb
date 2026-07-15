class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.760.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.760.0/ward-darwin-arm64"
      sha256 "11ecb21823f6ed967576f73e7302bbdd63939fb98c7e340dbc3543cc4d8de510"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.760.0/ward-darwin-amd64"
      sha256 "4ff61f62c222bbf684cc483becade91887aa03f80bfa38d73cf250ffbfb9fa37"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.760.0/ward-linux-arm64"
      sha256 "9d883b1dfbff568beeb660459f4d35c5ecebe59685690617d4e0886f36f9600e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.760.0/ward-linux-amd64"
      sha256 "e74a7723bd7fa97396e6a0dc92bc406bb8366c0df1b975f392963c3bdddd10ba"
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
