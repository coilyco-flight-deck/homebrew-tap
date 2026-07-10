class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.587.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.587.0/ward-darwin-arm64"
      sha256 "70ca871c7e9b579baa7dd33df6a1a5bd82a6f038f920d7498e0040b1321031db"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.587.0/ward-darwin-amd64"
      sha256 "3453639a1cca9f2c2cfe7e657ac38ffd297661d70b0852f7598f66163f6197f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.587.0/ward-linux-arm64"
      sha256 "d56a9fd9725d2c4f4e5fd02fc190bbdb1c05907887023b1e59170805e4b7d1c6"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.587.0/ward-linux-amd64"
      sha256 "956f9002610591a36bf380be12ed152e5e34d30d5dac78a973fcb955c891e16b"
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
