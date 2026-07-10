class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.568.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.568.0/ward-darwin-arm64"
      sha256 "ce32293b2eed986a7acf078a34eb2839b87a33436a793f7a5154b3c0cc0e1b00"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.568.0/ward-darwin-amd64"
      sha256 "69d7e3083ad5f2e39e6fb1f91cc4eade1d1753f47d489f10e66b13def4fa6a21"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.568.0/ward-linux-arm64"
      sha256 "a88ab5fc831eec8e73bfbb73a4554f2b59c0210399acc5dba27ba57a529de9b0"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.568.0/ward-linux-amd64"
      sha256 "4f7847aacce2f57dc5685f4edd04ed597cdac449773eb05fabbbcc77de6caed3"
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
