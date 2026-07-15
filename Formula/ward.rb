class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.731.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.731.0/ward-darwin-arm64"
      sha256 "9d58d286f764b300d531f15087fcc50d2f067acddc424e7f6e3a5d0fd09ae745"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.731.0/ward-darwin-amd64"
      sha256 "6968ac57b8d532369f6c3471c529f72a7fd620c80aad7f11d0ac3c6761a48dab"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.731.0/ward-linux-arm64"
      sha256 "1589f6373296e0a7604c696996f02d5ce4c558738cdb6e10c623f69694884809"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.731.0/ward-linux-amd64"
      sha256 "ec972317173ec6e1c06a4acf2881c670198c5bdd9e5908dbb818acc620413207"
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
