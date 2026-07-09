class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.475.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.475.0/ward-darwin-arm64"
      sha256 "7410bb4ff1ddd4c2902e146364cc0790244b215b24b4e8a6a3193053a54e1c0b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.475.0/ward-darwin-amd64"
      sha256 "9464339a326a3024928477e22d8f7c621c97641ba94a0a9d199a4856d399b985"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.475.0/ward-linux-arm64"
      sha256 "58b766081e018c23031ca967198127570bbeaab9212d32b4b5c6d068a3a88847"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.475.0/ward-linux-amd64"
      sha256 "d1ef4f11681b320b31a0028a963f1c9a8dc6542f913fd5dffb5adeabd8e07c54"
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
