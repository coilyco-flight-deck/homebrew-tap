class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.679.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.679.0/ward-darwin-arm64"
      sha256 "50ba1e4923a122f539258a5377a164d11ecdd265c80c2f70bae4b5d50041ebe7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.679.0/ward-darwin-amd64"
      sha256 "f7d02d65d401a8bcd8b6b4b1fe59c800b0faef5d83ba1e66403554af15d45c82"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.679.0/ward-linux-arm64"
      sha256 "3894d075936a6034b121b3defecf434deea717773ea2d2779be32fba2b805b31"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.679.0/ward-linux-amd64"
      sha256 "bbed3b6ba2321727096607b91b67f2e943efb1270ce871c7bbd0c7028bddbe7b"
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
