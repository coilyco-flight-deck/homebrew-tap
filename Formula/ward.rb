class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.630.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.630.0/ward-darwin-arm64"
      sha256 "5c98b332782dde48a3c9ebb88f84ec985184c7cc739ab5a0dab294dbf3d6f160"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.630.0/ward-darwin-amd64"
      sha256 "77143868ca50e5b0b5f4ec758c5181460fc8e4292e5b4f3e30f49189fea5b4d4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.630.0/ward-linux-arm64"
      sha256 "4d0e4a61c6335d0140f8fe6d5433b6d823624cea7300af84dafbcd4cd03d0129"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.630.0/ward-linux-amd64"
      sha256 "44f7489af7f43bba37605e9655d3637f2fced00e992f2651e558438a0280c4d4"
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
