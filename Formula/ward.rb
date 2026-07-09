class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.500.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.500.0/ward-darwin-arm64"
      sha256 "f1700ca78e6c50fbe802112b3d77639c45693d1db0cb95028a2e371d07bd10e2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.500.0/ward-darwin-amd64"
      sha256 "9b1933dcb75007f7bd35051b450d1f38049bd24b0adba180e1deced77e62f79d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.500.0/ward-linux-arm64"
      sha256 "69518bb790e09b12023c24cf195e5b73997f2751161307de746c0ba694ee30d4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.500.0/ward-linux-amd64"
      sha256 "730e006aa58a0ede9f5c5dda43d5b40eaa7749fe0cf7c9b8d499e8947ba5170d"
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
