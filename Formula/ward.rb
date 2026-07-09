class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.480.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.480.0/ward-darwin-arm64"
      sha256 "a640d93789e7dc8fc015f933079a8747398378ca08bbf5020215a521f5a5dee3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.480.0/ward-darwin-amd64"
      sha256 "7b67f85a427cfa99cfff063c89ea3942edc9494d06e65250bbdceac7d3ad7486"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.480.0/ward-linux-arm64"
      sha256 "9ccf0d0f2611ada336a22b4169346540861b0ded36508661d71041e4ac7f55db"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.480.0/ward-linux-amd64"
      sha256 "7eeea3b2ec5ab8a078d485efcf793b32be8197e369295690e8e3316ab551308d"
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
