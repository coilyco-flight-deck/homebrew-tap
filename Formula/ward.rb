class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.466.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.466.0/ward-darwin-arm64"
      sha256 "a3ca3d68d95821326553a83e8d48632ed68beed5d830e722a07578a26b25a366"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.466.0/ward-darwin-amd64"
      sha256 "b4f5f1852db6a886cddf522df0f89025b15e9751bf0ca24316ab8e2b03a51a3a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.466.0/ward-linux-arm64"
      sha256 "c7c6ab0af0746ea099a77881f95bf1c25dd473314f6bfbac86264e6e818fa966"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.466.0/ward-linux-amd64"
      sha256 "1515868cc0649b3d4e37add1a6db415150ad479883ed34d6b3868f7b9eef0886"
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
