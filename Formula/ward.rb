class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.454.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.454.0/ward-darwin-arm64"
      sha256 "01371e33f82f358a422cf330ec9b06d8056c95a1d3cf4c3b719cd07839d7c67e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.454.0/ward-darwin-amd64"
      sha256 "fbee8b4968748f2e0718c71f9b3febe0ab758ce1779e22f98747cf2c071934f1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.454.0/ward-linux-arm64"
      sha256 "0ad5ffc3762cc389969ec6fd62c794bfc3c585890a2feb801b8f46d783339e91"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.454.0/ward-linux-amd64"
      sha256 "acc4d5926fa76fb0aa8b0c0c5d6dfe525158f4dd9f1c409c46cdfeeeb099536f"
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
