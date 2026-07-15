class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.722.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.722.0/ward-darwin-arm64"
      sha256 "8443d728640a090d1604109fc4e4ffc00e368b0243e9ee95e288695fbe57a562"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.722.0/ward-darwin-amd64"
      sha256 "038574d5695ea29ff8dbf5045a71778769f24692e29d6b6f6251ead0a2f434af"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.722.0/ward-linux-arm64"
      sha256 "2eda181a930d7215c3fb830c19d9efb291a14407f4af45b7f567b3a15b4a7c66"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.722.0/ward-linux-amd64"
      sha256 "1ade23b592f18d18c47194444bc94d2fc7fcbe8dabb4580bd92eba045a411aeb"
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
