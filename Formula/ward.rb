class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.494.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.494.0/ward-darwin-arm64"
      sha256 "8a6728a4d35f298aa4141f519792b55d95d2fb7e301064646be902afcb3bd9b7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.494.0/ward-darwin-amd64"
      sha256 "9df59f3b53bb3d034d612d90629c82fad6412d11bfac149387f33c554d4710b3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.494.0/ward-linux-arm64"
      sha256 "6e572167b8ad53d74166401b8b0a3949b7e16e76f4f3cea196efc7d7887e6437"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.494.0/ward-linux-amd64"
      sha256 "cd503b48c09a15aa21a1ee22c19eb4b32c160b07d15c55767846836c15cf97f1"
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
