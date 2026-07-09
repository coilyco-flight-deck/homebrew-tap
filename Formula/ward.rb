class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.491.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.491.0/ward-darwin-arm64"
      sha256 "9633019fe3f9f322dba7888a5f33ac46ba92ec1c0b13e50b9959123a5708e65a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.491.0/ward-darwin-amd64"
      sha256 "4a51f2398603259784fb96b7bfec97b4e824f1b23e25295e3dfd529930b5776b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.491.0/ward-linux-arm64"
      sha256 "d1605ab8d6695aff60e6618e33f4f1d6331cbf4a42095f1630f2f36213beb76f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.491.0/ward-linux-amd64"
      sha256 "1802741d28776df41b26a577fb3d8c5e7f8572e812d7aaf3787ffd4ffa5632b0"
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
