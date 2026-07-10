class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.576.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.576.0/ward-darwin-arm64"
      sha256 "578bf858a38f0159fcc951fd9293b299290f25f5e30a24409fd7d738341574c7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.576.0/ward-darwin-amd64"
      sha256 "c917c98c92851402f2e6f9e60d305779e9a3d46d2005d9a7d146bae067f52e0d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.576.0/ward-linux-arm64"
      sha256 "1a3ae77a090dba5743deb026bee0e2b38e38bdc12b84a185815044dff89fb776"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.576.0/ward-linux-amd64"
      sha256 "6746c44de35b8d513b5a764acca1ea30a39d1f432277c2b40234e4d470d7ab5f"
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
