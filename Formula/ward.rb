class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.715.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.715.0/ward-darwin-arm64"
      sha256 "9ed792ce891b734c7f693e1f14964e28c2de9347239d0ed0a6611355be828cc0"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.715.0/ward-darwin-amd64"
      sha256 "648f67cc3f6069705393b5e55aaf6f80919b891de09de5fd8dd756655a792b19"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.715.0/ward-linux-arm64"
      sha256 "93d9949505bbd587a5f29e6c31e04d4a9241dbe7b53edfa32385ffdd9a151313"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.715.0/ward-linux-amd64"
      sha256 "49429e2232e83abc86285dcc5a82eb951c666cf9c08487cf0b6ab8023a8e2e7a"
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
