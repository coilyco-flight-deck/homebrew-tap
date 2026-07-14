class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.686.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.686.0/ward-darwin-arm64"
      sha256 "fa25a60362fece487f2df0020d54a424a346c33fe3eb65e59dbdf50c335b8d62"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.686.0/ward-darwin-amd64"
      sha256 "01796c438d4ca3ed255f9e075617e3a0473df617229d28c6e294bc3f35a5e2bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.686.0/ward-linux-arm64"
      sha256 "9c6727325fda873fae14c827bb1356b4a3dc8a062a416ea59ff845bf93005fde"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.686.0/ward-linux-amd64"
      sha256 "7ff2b9c4799cfe1caa684397b2ade3e3c4544d019c326ebcba5fafe9b7d89050"
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
