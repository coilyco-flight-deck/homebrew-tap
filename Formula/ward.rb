class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.728.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.728.0/ward-darwin-arm64"
      sha256 "53b9dbc652ec39f5c4eb320edba94297dd0764c6cece0a6f745c01c197036bb9"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.728.0/ward-darwin-amd64"
      sha256 "ccfb8c0612c903e530b1b3c51fce0c32a5f19a4b01406ed61969a3b36f2efbca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.728.0/ward-linux-arm64"
      sha256 "03f4c879cb30a8d9853f0ac0b1d51bfe76da1e386a6cd22005e8f6f95fdcf725"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.728.0/ward-linux-amd64"
      sha256 "a67ba6e1f5653048d040226b459c6f7b94b43aebfa872434814fc7f91ffeeebe"
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
