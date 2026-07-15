class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.750.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.750.0/ward-darwin-arm64"
      sha256 "4895ee983e9a30cc559cc7b8f2bfadfaa6805524a4db6e0c168620865d439eb5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.750.0/ward-darwin-amd64"
      sha256 "adc62ac0852e9caf4475d70aafe72bd12d36b42eae789231e5a87889edb7256e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.750.0/ward-linux-arm64"
      sha256 "73b40f05e9e3aff2929147b9b70b13539004e95eb4df0d4893b9fbe46b84ac9f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.750.0/ward-linux-amd64"
      sha256 "95e01e6bc9fa23aebef0d56908b253e0760902af2d29d13ad4a3c6a9a970e61c"
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
