class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.553.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.553.0/ward-darwin-arm64"
      sha256 "5cf6b76a389d146922e3dca7230d0ad310cc18681b77b9541ca5905466584cbe"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.553.0/ward-darwin-amd64"
      sha256 "46ce91ecd9ed573a09b491bfca922d170ab45f6f69fb7caa052ef943302e93a9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.553.0/ward-linux-arm64"
      sha256 "7ee7ce0ce48be3a4e90ca0aedbc840a6b541f3a1d306bed1c3982d2d58f3e59a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.553.0/ward-linux-amd64"
      sha256 "b67d9e63dac7f780c50f197faef6117a6a85fd7051cba2f07a3f0b7e0911a01a"
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
