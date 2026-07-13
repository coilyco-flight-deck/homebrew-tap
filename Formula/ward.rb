class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.637.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.637.0/ward-darwin-arm64"
      sha256 "38889b40ecedd1b1246b644110e360360085eebfd81b9138b9405c796d10e769"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.637.0/ward-darwin-amd64"
      sha256 "a5e79e226a4ec2eacfff5a351656d11ad741e116ab6116562e3c82b7e59ee2c0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.637.0/ward-linux-arm64"
      sha256 "e0e7498b44d22494ef2f10ba7a6ddd60f95374ce4f065fe6a1d9c9d7e65660f3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.637.0/ward-linux-amd64"
      sha256 "5e6e7ff0828ad54bf9166b6038226c085fe03c0fe64ba809bcce99901b72c239"
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
