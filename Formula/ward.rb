class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.673.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.673.0/ward-darwin-arm64"
      sha256 "563475a2875e1daaaf0ccc5737d66b6d5a7fe438f7aab4bd6872651c96e9ced4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.673.0/ward-darwin-amd64"
      sha256 "14c3aa29940414e63f4d2caed3000739c962e5cfb35ac76c08d0b3a0fc6628db"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.673.0/ward-linux-arm64"
      sha256 "7d134934657620b2a69ac74380e8bdd0b8df45d6abaa2f9dca1c8deaee2b1fd3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.673.0/ward-linux-amd64"
      sha256 "eb3abe610a591c43ea25ab3707fced41fd9aabfe6a0f3ac1ea572dc7723d874b"
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
