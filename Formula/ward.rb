class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.711.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.711.0/ward-darwin-arm64"
      sha256 "887316c25aaf83928bacbde3b4e827dd1662a0f4b383aa193af1b41d696b83cb"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.711.0/ward-darwin-amd64"
      sha256 "fff04a048a069f5e73a6465a1a830ca36c3f2e127a205de6b3594e2133485db7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.711.0/ward-linux-arm64"
      sha256 "b456e810a540c9d2f73fd9047c47ca2624aa9a5b1c0d3d1611a32512adda41d1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.711.0/ward-linux-amd64"
      sha256 "dc749d00d3c5f0516a36effc5a57c9a1090008d0fd7bf067182980168fa95807"
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
