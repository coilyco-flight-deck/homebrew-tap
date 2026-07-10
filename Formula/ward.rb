class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.617.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.617.0/ward-darwin-arm64"
      sha256 "f0413d1bf0233c5a18c2755a3f4743e9825f236e440ecdca736d0e05d0f30a56"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.617.0/ward-darwin-amd64"
      sha256 "de981b597d457548f282c88f82fa618ae401967d67a31f3eae71a9421731ce25"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.617.0/ward-linux-arm64"
      sha256 "f1de29dcbc7e78d375ff9c4db178848ee178fac9fdc75a91afdefc96f7eee044"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.617.0/ward-linux-amd64"
      sha256 "04a4720acb8b43addf5def98a1ffa97159a39dd2d87652172555bebfb231b645"
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
