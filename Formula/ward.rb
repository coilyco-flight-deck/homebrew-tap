class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.526.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.526.0/ward-darwin-arm64"
      sha256 "58ca960d04023319e0705dee0d7643f2898d46e3e1613c8e6a930d641dffe726"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.526.0/ward-darwin-amd64"
      sha256 "73ae9ed518209061898f117fce3fca5b3914ca053656a32d679c076f43b40a1f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.526.0/ward-linux-arm64"
      sha256 "1a4a37a0f96c1406116e76d799cb66d910642d534674f79bbc7ae42ee68b40bf"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.526.0/ward-linux-amd64"
      sha256 "951cc9c9f4134b58ee8c260ca16375c60a24c6bb0fd4f7e4846a74416c359a91"
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
