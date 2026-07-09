class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.503.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.503.0/ward-darwin-arm64"
      sha256 "6ac6b9b1ef8d56cf7462c9c17dc061bf6813e15837f45c7f656e608167578870"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.503.0/ward-darwin-amd64"
      sha256 "04f2cae744ba43aa5cbd139bf8b06c328da0c147fdde968f9030418b6379cd94"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.503.0/ward-linux-arm64"
      sha256 "309f6dc8cc92d722750e1765400b2b247c68c78e2d1964457b5fb3ac57c7f3eb"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.503.0/ward-linux-amd64"
      sha256 "5357063ff81d2e4b58ecf93cfac45e087bcdc8825d5910ed678773928ee408df"
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
