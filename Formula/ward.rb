class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.502.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.502.0/ward-darwin-arm64"
      sha256 "c1824971d5a3454d5c581e70654af71a78ebd20ae9cf5ddf8a8a03c9f6f02085"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.502.0/ward-darwin-amd64"
      sha256 "0a54d4ddf6dc15029ba61238a63a0ea6e05e2893fe12207c3b6d1d6d5628f188"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.502.0/ward-linux-arm64"
      sha256 "3e9183ac5e1edc8a050a2b56bdb3438dd9cedfd5d5b3807208c4376a10eb021a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.502.0/ward-linux-amd64"
      sha256 "b460b2184adebc1548df514c8a62e6a76d6cce7b18904f983c42549bbf259985"
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
