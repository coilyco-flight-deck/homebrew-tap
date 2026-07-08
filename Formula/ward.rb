class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.465.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.465.0/ward-darwin-arm64"
      sha256 "6e4fcd3b73a0ab5035648a83e1b9ab06cbb667036871158a2cee0635ea406284"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.465.0/ward-darwin-amd64"
      sha256 "12f9d42c6b851c8146c0607d4c282d6cc8c0e54348ccdcea93ec47258b7d8df1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.465.0/ward-linux-arm64"
      sha256 "383670285cde0668cf51746615481a1d8b5c97c6589e89e314f8d5bd19404249"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.465.0/ward-linux-amd64"
      sha256 "284f2db667f07e20d7a553e7939817df292c20cac7a099f201ba5f886aad81dc"
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
