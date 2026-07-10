class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.592.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.592.0/ward-darwin-arm64"
      sha256 "74853c1899f25434fb4d304d1d6abd55f555f3a624c89e20f8a7c98418440a7d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.592.0/ward-darwin-amd64"
      sha256 "08a94ce04c5b0d0001eb511f90474332342b3e873f162bdb4d52140e41647f8a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.592.0/ward-linux-arm64"
      sha256 "29b625bc505aeaa6f630bd3ed982c6d4e79e9652c4dd4cb8413ecd8fc0e0b1e4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.592.0/ward-linux-amd64"
      sha256 "880e84f551d302b316e98c034bf724ad541334b2ad533b0791ff9a9baac2d549"
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
