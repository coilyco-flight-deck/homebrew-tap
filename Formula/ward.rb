class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.704.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.704.0/ward-darwin-arm64"
      sha256 "f77e38f098705dfefa3c0b8b6c2426749f9c7e64e704810cbef1b61a70d4bfdf"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.704.0/ward-darwin-amd64"
      sha256 "4da765cbb6431b0aac50dd39b10f33cf57d873cb7c6d3eb6cbccd0b8470d60fd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.704.0/ward-linux-arm64"
      sha256 "d28f26e3e49d2393598744c7f1571de4d44ea4693e2e63421346ab5a7d69a4af"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.704.0/ward-linux-amd64"
      sha256 "4ec5202accbcf7d68b559793673f9f56b1a0f599f033d7bbd50b1c8dcbc799b3"
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
