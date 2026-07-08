class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.463.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.463.0/ward-darwin-arm64"
      sha256 "2a05b5d4d5be1f82eb751a1a23f0c50b9a5cbf440e71c6e0d11644de763393e7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.463.0/ward-darwin-amd64"
      sha256 "02d29198e2eec1f415913e4325385f3245191f95417d1435b2279c0eb863ec43"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.463.0/ward-linux-arm64"
      sha256 "9df927b2d0f5847b166ed0e76b9b2a9a49e6ee6f4e41c63fae96af11be90b68e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.463.0/ward-linux-amd64"
      sha256 "cb5087aefec9162ec0dbc5fe8831dfccdf23608efa2a47e574d8b5dfceb6c1d7"
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
