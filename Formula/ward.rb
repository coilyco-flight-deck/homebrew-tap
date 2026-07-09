class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.530.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.530.0/ward-darwin-arm64"
      sha256 "6ae76268cc48c04f0f76e62145d3fd18e51275db5c9d8780b61160bde0317b6f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.530.0/ward-darwin-amd64"
      sha256 "4cab166f6336d46779adf5a163f5d2d9dd9ccae9eaca418f13c691834cf19715"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.530.0/ward-linux-arm64"
      sha256 "d4dafe0c1dbe31bcd93aa71c63d32140b43c0a80eb72ed53c8f881fe82639db1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.530.0/ward-linux-amd64"
      sha256 "0d957bf63a0fdd23eec22b77caf62b16f5e7fabd4198ea1dbcc5195c718205b4"
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
