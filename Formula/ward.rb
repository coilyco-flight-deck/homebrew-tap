class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.498.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.498.0/ward-darwin-arm64"
      sha256 "a9ba1938842cc8e5c135cade7863ce06d788e96ab6bf57fd02476d18b366d28e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.498.0/ward-darwin-amd64"
      sha256 "bd33903ae6a285c3a927be2e17deb7f5e60ac5827dc46e455687fccb2dec5e05"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.498.0/ward-linux-arm64"
      sha256 "8f338d847583a82b368497f9a6681ff29047300e031df412fbd368b176a4703b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.498.0/ward-linux-amd64"
      sha256 "b40ac979fedb3091ee0e41e039cc4a00bc5184d8cfa482bbac33f66716dd42a0"
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
