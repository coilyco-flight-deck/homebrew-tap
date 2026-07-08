class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.470.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.470.0/ward-darwin-arm64"
      sha256 "136974a82618d6ffe13a2c4d9769f101ba25c4cb570d06de21962dee32f2ee0f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.470.0/ward-darwin-amd64"
      sha256 "004abee04d4abf99fdbdf45e65b041aa75d34612fa8d08191b0a16c81b510735"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.470.0/ward-linux-arm64"
      sha256 "25cc112e010188d8f3189bfd35c156e211ff6a2e561b548c4abd1a839b08e205"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.470.0/ward-linux-amd64"
      sha256 "f0114d1c84cb1bc58824b4f3d205f78a4278ee142cc679c0ca0650ae65e33a0d"
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
