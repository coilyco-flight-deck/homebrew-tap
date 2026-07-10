class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.574.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.574.0/ward-darwin-arm64"
      sha256 "600518214c0eaf8deae9bf8a3fb2a4c4e88db6b33e541aac2de906182d080831"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.574.0/ward-darwin-amd64"
      sha256 "a6d64fe5a8fb7385ffff3d79a8d618978bd6ec142a6bb4ca4f5e9d60b4fd37eb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.574.0/ward-linux-arm64"
      sha256 "4d33583fd10737f9812c13e3280406fce9a3680e826cfebafce0e5bf1d2c8030"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.574.0/ward-linux-amd64"
      sha256 "478daa7187e65ff9b59b0301c461d5997e84def7636c2f1fd00a88efa0ed4714"
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
