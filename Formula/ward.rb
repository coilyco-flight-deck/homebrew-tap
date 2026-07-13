class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.635.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.635.0/ward-darwin-arm64"
      sha256 "73ec67fb3ca3fc942033909fcc56190a292c92a2c3ba1d35d7a87ae767385bf2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.635.0/ward-darwin-amd64"
      sha256 "e29ffa2331c3a45fc4d2a08688d7f5a13b2af2f8d0f27ecac9db575d12951cd0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.635.0/ward-linux-arm64"
      sha256 "73ff79dfc502e03e87306a27f89bde5694ca41ed056cc7724a7992f21dd4e4ef"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.635.0/ward-linux-amd64"
      sha256 "a596cd37e7f108eb75e189fe65d6339daeba71b9ded957f3f5b263087016a0d4"
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
