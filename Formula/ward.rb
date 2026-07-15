class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.698.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.698.0/ward-darwin-arm64"
      sha256 "28b6a165dd74298ac225e1bbace4e11baa9509a92323195f324f8e8b56d2fff5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.698.0/ward-darwin-amd64"
      sha256 "e3c506561821fdc120eb186b9d1965ece238440d5add03868c2e1257b71641b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.698.0/ward-linux-arm64"
      sha256 "73025e3d039bf4fc7c0c9350ab0023aafec1ae12c66405ca24ff107269b33466"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.698.0/ward-linux-amd64"
      sha256 "0c7ea6b37b44f5a8c86989f247568560fdab2481f7e00d3b9dcbdaba03bb4095"
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
