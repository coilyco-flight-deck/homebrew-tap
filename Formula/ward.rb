class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.604.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.604.0/ward-darwin-arm64"
      sha256 "5f764d59e9179e6798a37fee8fe7a2398e262b9689b3f6b2be70cc3a63497892"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.604.0/ward-darwin-amd64"
      sha256 "8f43ccf24fba223e9cd349ce1480bbe87ba804da6c4cb1390518bc709859b951"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.604.0/ward-linux-arm64"
      sha256 "ae44bf3eed5bcd66e3665980e0a068e16cfa2372d82aac7538a3daf2e0519fe5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.604.0/ward-linux-amd64"
      sha256 "b45ca7de913b7c3652bf5492fbd77526e65b486353d9d1a3bfab75ce0136f442"
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
