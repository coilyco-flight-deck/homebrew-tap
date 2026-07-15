class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.703.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.703.0/ward-darwin-arm64"
      sha256 "bc287ba42d4296a6b00c2724d33597b01a7013230484b22dff6c6b5fece4b23f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.703.0/ward-darwin-amd64"
      sha256 "c6d682e6dea0f6620788f4bfd6695cf393cfbf290b27b4d47276aad6309c0df7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.703.0/ward-linux-arm64"
      sha256 "b2a2c2081d5b64e55cdd607c425c52836391f375c98538a4d013028719b3c29d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.703.0/ward-linux-amd64"
      sha256 "bebb3ef12b7b40eb041cadabec23b0bd7bd4ba3330c4342dc3d65244cc2aeb6d"
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
