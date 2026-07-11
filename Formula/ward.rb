class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.621.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.621.0/ward-darwin-arm64"
      sha256 "8b28ac891eb2c8f068973f4203916412fc4e696515cf5301f6146de882d9d08a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.621.0/ward-darwin-amd64"
      sha256 "662c33dbe39c71d7d9224dcb0899ec1c93cc9ff54af5cf1e6376eaa417889df1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.621.0/ward-linux-arm64"
      sha256 "8d017ae81195e3d46ab898ea2d024cba45ef9a8f8df1a37a267bdf2e2d26cbec"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.621.0/ward-linux-amd64"
      sha256 "59394288089906b564dfec91616b3aac23e705fd4f3a096fba3eccc1362cb3bd"
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
