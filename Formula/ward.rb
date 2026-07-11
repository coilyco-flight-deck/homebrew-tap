class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.618.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.618.0/ward-darwin-arm64"
      sha256 "d52f81cfc18eb398d1a09969b5fcc8b6875418b1ee6d7db746096e47cf866f85"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.618.0/ward-darwin-amd64"
      sha256 "4ce89baf00dd1b160bf4e1f96d5e2607bba6a801c9f4558e3f715c633836c4e2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.618.0/ward-linux-arm64"
      sha256 "8acaf428ebd2f32765bf562c5bf296ff1965b7a34312c899673480a1d5b4e01e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.618.0/ward-linux-amd64"
      sha256 "8f408bb92b631987bb9ba5cc825aa070456555c17d2806b571b3e7786c0f12c3"
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
