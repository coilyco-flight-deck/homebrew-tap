class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.695.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.695.0/ward-darwin-arm64"
      sha256 "978ab3c1ab370c0eb4d45ebb0c7b1d0d37d5d068f936616e6aa05f10fe337204"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.695.0/ward-darwin-amd64"
      sha256 "2d2e895f9ee18c24c764463364e957e147d80e8f512663e14672e06847952830"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.695.0/ward-linux-arm64"
      sha256 "4536d6a448c93e83f128693afb5fffb44cace98ffb98390cb9579c04ada57688"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.695.0/ward-linux-amd64"
      sha256 "8c57c8007cc4899f0787bba7b43bbc9075ddd304e0ad15bf4d8b6536c64389f0"
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
