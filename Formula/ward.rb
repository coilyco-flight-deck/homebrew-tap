class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.685.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.685.0/ward-darwin-arm64"
      sha256 "6d9c43abb76a504c9f4a4db5f52506394b8552f1437826ab27729af32a354cf2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.685.0/ward-darwin-amd64"
      sha256 "2361b77b2cbe325fc34b0d5eebdf7efcac35d541a2f790787530750ce8c78c6d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.685.0/ward-linux-arm64"
      sha256 "b503268a2ec4b1551b7692d0da6c98d2ffc408803c83276ddfcbc20630c4f3f5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.685.0/ward-linux-amd64"
      sha256 "379f0d01eb6994d367d632ba6d2469031ca8ca941280413aaf8472d66fee5579"
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
