class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.585.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.585.0/ward-darwin-arm64"
      sha256 "9ad033432b6aaba76c7bda0c06f440e001327fbc8eccd6350d8cb742910f7448"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.585.0/ward-darwin-amd64"
      sha256 "fa7370f3f9b1b2c03debc74a72b58f4ed07d1ec79b62f90927d8b3555cbbbeeb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.585.0/ward-linux-arm64"
      sha256 "96564bd4599d6247d55ae175cf1bf707865152e8f85f79aa423e3963f5f319a0"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.585.0/ward-linux-amd64"
      sha256 "9f767978bf127bc69f9790b82a593295e376e615e5f2ab1d1c064ad5faaa479b"
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
