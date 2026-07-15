class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.720.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.720.0/ward-darwin-arm64"
      sha256 "0787ba7a63b2f2119b785da8dfb2e76988103bece13b1dcb94e845386be0646e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.720.0/ward-darwin-amd64"
      sha256 "ee0228bcd1616240c7106ade313e38769a8c5d59c8d861c991b5bbfacb167e5a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.720.0/ward-linux-arm64"
      sha256 "14ce1b06e05d4c90b00cc87c438719449c5ef46adb4557d1bb135950330b7ac1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.720.0/ward-linux-amd64"
      sha256 "079eab5901ffe16e02c2f698cc5b59cf16efa74a08c21d0d69bb4dfb23c61089"
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
