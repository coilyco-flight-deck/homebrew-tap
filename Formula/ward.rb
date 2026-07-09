class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.535.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.535.0/ward-darwin-arm64"
      sha256 "d3f34e9093674d52fac78e9e8380cac4becaa9a01c6c778fd6d58509ca958050"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.535.0/ward-darwin-amd64"
      sha256 "6def83df4f8938d6f781074bc63f8265c66ee2470d152ccc2a12b50cbfd95c66"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.535.0/ward-linux-arm64"
      sha256 "caecd47a43a701e5b177e6c9368df74a990be1f68aa5814f0083c7ec12d87dc2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.535.0/ward-linux-amd64"
      sha256 "04997a3ac5392004554e472832aa3d2849d84b62eebadf14fb8c776289a254a9"
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
