class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.566.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.566.0/ward-darwin-arm64"
      sha256 "103266bc437f6248c9dd43e28d5710788dd47395954fe0927721eea8020f4334"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.566.0/ward-darwin-amd64"
      sha256 "2166881f279ef5d270d84523857672e53e1dd08f56b11069c601eb3f34d3c5fa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.566.0/ward-linux-arm64"
      sha256 "289be67f82c1cd4603ef7e6298c870bb0f362af222fa9e25a0eb5c4c1551a957"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.566.0/ward-linux-amd64"
      sha256 "ca24599bedc29ed2673ea26cd7835cf120966e75ab2c2ec5abee584ae58d1dcd"
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
