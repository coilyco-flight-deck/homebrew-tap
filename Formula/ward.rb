class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.614.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.614.0/ward-darwin-arm64"
      sha256 "64962e006ba2573e2653eae279cbafb9af45af8e9a1a3e5936a063bc7d16c6dc"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.614.0/ward-darwin-amd64"
      sha256 "cf194fef9f89ddb56a5ec23a76109030db37a31df15bbf1eb6b6775087094a22"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.614.0/ward-linux-arm64"
      sha256 "0cda7e94f98d306a254cb9d075e8636b7624f997cdae94604ee1fc38624fb0cd"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.614.0/ward-linux-amd64"
      sha256 "73d6b96408811b3f4f0a3f4e2a7e0171723e67d146eb36347a8b75d6595d1e81"
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
