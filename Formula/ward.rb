class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.501.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.501.0/ward-darwin-arm64"
      sha256 "c94ec10cd2d87f15b7b782338c329a83f8d0561df2e2f79d2c98a4d7df7f5ca7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.501.0/ward-darwin-amd64"
      sha256 "594f4d1a5e1eb7147349a2491962d165a8a45af5b0bdb3dabecb701047ba48c3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.501.0/ward-linux-arm64"
      sha256 "990afaa5179e599b0b2b2e9875992927af59355a3661bfa35407aec000c0957e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.501.0/ward-linux-amd64"
      sha256 "37abc0743cbca9b9390c5f9b67c47f7f102a3c9f527288da2a4895a0b692b551"
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
