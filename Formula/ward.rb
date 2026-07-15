class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.705.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.705.0/ward-darwin-arm64"
      sha256 "050408b66707af4958bb08f20e8f4f2e72662ee68ba535ff3b3d3946e01173a7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.705.0/ward-darwin-amd64"
      sha256 "b87d0cae39a43221d8fb9c452256e6ee2da68dfd8bbf36a092ac7e8148f151a7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.705.0/ward-linux-arm64"
      sha256 "e6abfb97a945c0d23443bc1745ad45b3d2af3249ec7bb599dc9bac9c467a0f02"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.705.0/ward-linux-amd64"
      sha256 "9eb7e2129b6bebcaac9edf84e3cb17a7388446e958a2d7624d29bb75eb7b3082"
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
