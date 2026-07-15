class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.700.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.700.0/ward-darwin-arm64"
      sha256 "bd9f9a1b714a593a10f307078608f188776eab3d6ac91f9bf344821b50d5ca6e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.700.0/ward-darwin-amd64"
      sha256 "3f0d59a59a4ae2137adeb66fb5559da8badfce96ba333452c1f4257bda03aa71"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.700.0/ward-linux-arm64"
      sha256 "13404af44f22f74b1039291dd8f443aa38d569b00cd4028453b3dbe5a2c4ef4d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.700.0/ward-linux-amd64"
      sha256 "1dd807f5aa0dfdb19360e0645169f7efc9c61abd84b74ccb190ec72818187bbd"
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
