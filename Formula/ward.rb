class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.483.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.483.0/ward-darwin-arm64"
      sha256 "0b95fa33be21ba13ef7e05281269e2fd5bfcfa6c02e2b6977c516dafb307c193"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.483.0/ward-darwin-amd64"
      sha256 "d18b3fdcbfc5cda5b477c1256895b9b1199ba82b11cb15b0de70dcf3a1cc5591"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.483.0/ward-linux-arm64"
      sha256 "4395f6967fab9b390e34812a32721d26e0938466a01aff48391df439b7e9f7fa"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.483.0/ward-linux-amd64"
      sha256 "a165c297f4739678cbdc8668583c2efec280f239cc155d18ebc71e86bf843c4f"
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
