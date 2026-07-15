class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.710.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.710.0/ward-darwin-arm64"
      sha256 "dfa1cbf03b7f9ce539c9c04448ebc5775a6b4b288cf421386a50024c2e0866ef"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.710.0/ward-darwin-amd64"
      sha256 "5dc4cee47e2899bf2332e88acbd58a7b985d1d511d8da4d8e5c81797702bb5c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.710.0/ward-linux-arm64"
      sha256 "2d5b82da8b168a66ab7046ec63176d0145132d994ff9b05e9e48942a8258466f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.710.0/ward-linux-amd64"
      sha256 "64cece68b4ddac270240391b8eecf4eedec35286f4deec13b8cbb20f74bbdbb8"
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
