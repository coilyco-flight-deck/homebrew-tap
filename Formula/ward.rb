class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.458.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.458.0/ward-darwin-arm64"
      sha256 "208f3ac7caf5957431a9527be3482ea8e16ca7bff6989616e93b2a90f232ed00"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.458.0/ward-darwin-amd64"
      sha256 "a11e6a12d58a4106e9b0c7469ccb46134ea55cbdba27e41c8048ead220f7bed1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.458.0/ward-linux-arm64"
      sha256 "4e825d4da0f6dba02ed98c5f634428b530d51ef3d9e11ea491cb4b42d8bd2245"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.458.0/ward-linux-amd64"
      sha256 "15ab5646700adb76c9214600a1c9c4c62b902e95dbc5b33f3b87f0d63c8e5f93"
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
