class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.616.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.616.0/ward-darwin-arm64"
      sha256 "54070aeb402cb09def04e3e559f9ad85afb1d969d757aa5a2671c343781ff8ec"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.616.0/ward-darwin-amd64"
      sha256 "3df15eef598ee009b2adf16962a1097fb9e5e6bc04e048117670096130a5ff06"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.616.0/ward-linux-arm64"
      sha256 "129f37db60a9cc3028cd14ad29ad74e7d9b861aad1842d13d8914c8156c9bdf6"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.616.0/ward-linux-amd64"
      sha256 "a1b6bba7bfa71e36f219073c3afc9ead2cb9d445e1db3cf3f610a2b17fdc12a5"
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
