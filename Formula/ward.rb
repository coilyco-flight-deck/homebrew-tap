class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.523.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.523.0/ward-darwin-arm64"
      sha256 "25a314ee39f41893221c05feb2f4b172f6edf5ce33fceed9b206cdec93d99117"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.523.0/ward-darwin-amd64"
      sha256 "29c0111acec6c9f9c9d62114a6eb69bfea3cac3a71fa058955623ea92aec16c7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.523.0/ward-linux-arm64"
      sha256 "e2ed9de1c1f6a9f540f41ab56198a3e63e5af019cf497a2701669eb75fe9554d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.523.0/ward-linux-amd64"
      sha256 "c9263741cd787a21396e60130d495efaa1adcb9f37f633a7bab54fe9d6d0266e"
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
