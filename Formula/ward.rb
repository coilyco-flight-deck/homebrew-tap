class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.511.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.511.0/ward-darwin-arm64"
      sha256 "a7ffb8c62225dbfdbd0358298e4756f02a6390d6fd67b9e84a46a334f7ad469c"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.511.0/ward-darwin-amd64"
      sha256 "cb5e79a36edfa33fad1b9d2b2dc2aa13337d3dc9e1223e1d4b442bb21d0bc9db"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.511.0/ward-linux-arm64"
      sha256 "769c022cdcf80a6edd46acb6707b109341d1d5a04cae06bfcd6fc1fc63eb9f71"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.511.0/ward-linux-amd64"
      sha256 "02e4817f2f9616b5a31b21fdfd732bf81ec038a44dba10c5c94f594e4dbba329"
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
