class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.648.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.648.0/ward-darwin-arm64"
      sha256 "bc73a8c82202a1939df69d92f26b75c0736e1f3050d4c75f9baa2b2b81fc1151"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.648.0/ward-darwin-amd64"
      sha256 "cae7b240e493ba91ed6fcff07c6f27690d888328efae3815b47643d7c6b7fc08"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.648.0/ward-linux-arm64"
      sha256 "67b24bf01740373b8f16c0a82570332428bdc2de1ac3817e4e03ecbc3130a38c"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.648.0/ward-linux-amd64"
      sha256 "d8542e25536983c4fbeb312a58ed5546026f944a38832e8d09f71af3e573621e"
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
