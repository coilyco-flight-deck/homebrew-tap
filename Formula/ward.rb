class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.460.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.460.0/ward-darwin-arm64"
      sha256 "7e6a90aaaaeaee91673cf5e8a7b48eb56c2a18c17ed9475682781b6597a4e7c8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.460.0/ward-darwin-amd64"
      sha256 "7709f61c3cd6d08e2a9fe38ab0ac8d1ca6f4e034bccc6fa7262c002b790a2b5a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.460.0/ward-linux-arm64"
      sha256 "d92bdd5a28d0838744f1c966d25579f2f1acfd4dc64ece121cafb9a3b71f285a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.460.0/ward-linux-amd64"
      sha256 "54797e1d4f2d7212a4b9f3713b3d7895f8d4109e976c79f6dd2051010d1bdf9c"
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
