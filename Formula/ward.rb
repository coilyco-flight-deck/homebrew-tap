class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.643.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.643.0/ward-darwin-arm64"
      sha256 "01f59ca5ff70975f3d45464757c240aebb0dc1a7cf4b397307c2c9bd2cf976f3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.643.0/ward-darwin-amd64"
      sha256 "fa3e34af6861fa60cfd24d8f3a35e1cdcf56d19bab44155f019e517c815de443"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.643.0/ward-linux-arm64"
      sha256 "8e43499c52c696831e8283141384952a4bd9c5aa5f5c35fe9ec527ca08630e5f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.643.0/ward-linux-amd64"
      sha256 "2a52f84dede7a19c89dce1a79aef6da2a16dc899203ef1d1d517ca343bbb2a39"
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
