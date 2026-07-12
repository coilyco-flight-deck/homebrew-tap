class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.629.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.629.0/ward-darwin-arm64"
      sha256 "85d0dba3fbea9867ebdd195a08fe712fb3728dbb648b0b01507a35b66e988486"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.629.0/ward-darwin-amd64"
      sha256 "2bd305b11b6e065d714345f58bdaa3e58437a068a12781597b7c12a5bd5aa0dd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.629.0/ward-linux-arm64"
      sha256 "b86d07442d9f49fee2c2fdc3bcc89f00406d99c4729047ae29a8b295631ef58e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.629.0/ward-linux-amd64"
      sha256 "dd32dfb97d462dfb202b6dea97a6502626fe780f3808c28cd77d48a15d1b3f18"
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
