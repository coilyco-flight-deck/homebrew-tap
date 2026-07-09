class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.519.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.519.0/ward-darwin-arm64"
      sha256 "4fb0df6e8a951ccfca457aa6e707ca3d83d069efc356b314c7fa2efc8590f124"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.519.0/ward-darwin-amd64"
      sha256 "f48441dcc73fd9bfee4966cce4d35dc6e2b1e9f989f3eecd41351fadeebbb391"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.519.0/ward-linux-arm64"
      sha256 "92b4a41b88f9853904b4ba843916dec794ff394912ef8f2b9b5875ba729040c5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.519.0/ward-linux-amd64"
      sha256 "055efa9c0cbcd45f00e7103e7c6398744a9ea8e382a2341a3f4e4ac9cf77f854"
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
