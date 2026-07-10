class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.609.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.609.0/ward-darwin-arm64"
      sha256 "157a437187f5ad56260a974e0b3604087a980ae7b17977c988b7ca397fb369ac"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.609.0/ward-darwin-amd64"
      sha256 "2acd19acd5de55c305a5e52f55fe5d56aca2a11192c0de0781feb3cc19ab5e14"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.609.0/ward-linux-arm64"
      sha256 "4dc15900682626d76096e010feea108156b0c81231f11d6315e547b3cbcecd16"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.609.0/ward-linux-amd64"
      sha256 "9aba1f4285d9f781c924e742dfcece0bc3189d1f6cbfefaef7f7c81d44ede695"
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
