class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.469.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.469.0/ward-darwin-arm64"
      sha256 "7edd3447a3092fedcaa6532f7d1e23878d34dd13de351a601cd2b074556a5514"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.469.0/ward-darwin-amd64"
      sha256 "8c1b03ebb1272fb3ef539c07f2774d0f209ba7f2dd9e3a7b71e6f8b09b583d8b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.469.0/ward-linux-arm64"
      sha256 "bb8c7f5ded5f5b7644e50f519769a0706cb4c937001e547fad3cf636c515db0b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.469.0/ward-linux-amd64"
      sha256 "446fe531b911d4338cbb18bca24ce13548850fc4981acf0ac262fddf095843c6"
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
