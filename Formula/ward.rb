class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.459.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.459.0/ward-darwin-arm64"
      sha256 "5cb775b3e62bc7a83697a3a5204756ea9b5e8550fd44fe9858b0ae235ab0c234"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.459.0/ward-darwin-amd64"
      sha256 "e79e37d175bf148adf2c47b8a821cc6cd4d673ed4301cf4ae7e239dae068d5df"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.459.0/ward-linux-arm64"
      sha256 "7ac0bb6c5616073e2d46e79923cf35a12d82840aaa078b8c4170dbebc0281075"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.459.0/ward-linux-amd64"
      sha256 "666bb009263f296586f80b1fd4f9a2bf9fb00f9db6c1e3aeddf5b48f155c44d2"
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
