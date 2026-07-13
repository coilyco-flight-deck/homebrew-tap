class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.650.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.650.0/ward-darwin-arm64"
      sha256 "c4514f9b7cf969d81b01bec2fca2645daf24ecbcf5a47231829b0f986eff5921"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.650.0/ward-darwin-amd64"
      sha256 "ea5ecd5d87b3065f8b49d770538067f5c5e57f6e3a31dd928dd690f5527aba5c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.650.0/ward-linux-arm64"
      sha256 "7107d1142727d3e82dfb2407ab15f333e35adf6f03c0e18dbbb60f4c27fdaf41"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.650.0/ward-linux-amd64"
      sha256 "2bc703a0c027daea59ba21bb94ed72abe312810172cef442807493de54825009"
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
