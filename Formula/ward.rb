class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.729.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.729.0/ward-darwin-arm64"
      sha256 "7a0f9164b6ad9ea777ad84aa87cb10bcae0c76de16e35c27aa50af91e2443cf1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.729.0/ward-darwin-amd64"
      sha256 "2ab33e6107ed401dd9ff38ddf89f86fa764b2869ab2cf19963959b17ef32e127"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.729.0/ward-linux-arm64"
      sha256 "8044d8d108ac6b79e61ca671f667743f808bcd604711780549b787264eb1e279"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.729.0/ward-linux-amd64"
      sha256 "bae3cd43d6c2b0a3c6bbba6e751f479aef3d72e9aea17d73c130a1eb27165351"
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
