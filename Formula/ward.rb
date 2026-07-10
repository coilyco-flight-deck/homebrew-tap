class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.554.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.554.0/ward-darwin-arm64"
      sha256 "5df0e239c3d3312fe49bae0ac0da0a5ccbd33f9edbe182ab60bf3435e107ebbf"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.554.0/ward-darwin-amd64"
      sha256 "b180dd2a9ac01292a7989551d9b115f118e91913da6b0bdd1698ca245032b5b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.554.0/ward-linux-arm64"
      sha256 "bac0905a7b0e6e034d38c9076644a27646de47840434ea4098d7a1c3072a3161"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.554.0/ward-linux-amd64"
      sha256 "9f93346db31aaa8247166391860f8bcb4482b04f06f205fb7d799608a20a781d"
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
