class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.557.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.557.0/ward-darwin-arm64"
      sha256 "0738949e63f4d9d8ad72ef20c9d1ba2690a55f79b88d5977d1d2844cf52bec20"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.557.0/ward-darwin-amd64"
      sha256 "7a8d4330bffcebd9411df7aaca07e34d33cadaca4c0eb028c9cc0f1fc6a10a67"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.557.0/ward-linux-arm64"
      sha256 "ce721917126c16bc3adad36f53b273808bd06be95582777bdaa65a5f66754779"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.557.0/ward-linux-amd64"
      sha256 "1f2aea91118c2a07e35779a10d88512cd9e2e14ec974f0adb480be012267797d"
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
