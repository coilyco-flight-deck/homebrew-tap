class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.573.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.573.0/ward-darwin-arm64"
      sha256 "b9a612c19e3291ddd0d694e50cec528fbb076ed89602cada44f37c3c858e2231"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.573.0/ward-darwin-amd64"
      sha256 "eb32903f55b9b1b392347e9b409f90d4ad074510ee322ab9812ab5fb424c4ef2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.573.0/ward-linux-arm64"
      sha256 "dcaf9f540bfa1a9f1bf40b7dc65699390229374fdd5f55a8b90d3bc0fc3a8581"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.573.0/ward-linux-amd64"
      sha256 "f50746dd4667b240b512d74870b445ecc90c4c28525fc54280e248d2ad570a7f"
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
