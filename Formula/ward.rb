class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.661.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.661.0/ward-darwin-arm64"
      sha256 "e029e240ccb71e086d8b10487c37362a8b1faf681fe16660c34363ec7b06fe29"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.661.0/ward-darwin-amd64"
      sha256 "00a41a7ab80ea84edde1a46839d8211e95dc772599fda3863619a7508019c310"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.661.0/ward-linux-arm64"
      sha256 "c7251bd320a133118fbed4736ec4884bee6b5ada3be02a827d72c6a31374ae38"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.661.0/ward-linux-amd64"
      sha256 "2dae42dc067d2e26dc5d8f626541cf9b1c8002100526dd4b0313994ce0d05ddb"
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
