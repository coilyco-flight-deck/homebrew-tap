class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.707.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.707.0/ward-darwin-arm64"
      sha256 "e33e5a60fa14bbba6d4e4f4f6fca1c9626b904f328984662df61a2141c32492a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.707.0/ward-darwin-amd64"
      sha256 "a8c90d8d7eea02592a73d301bf66e5042865a96118925109675448be59ac2a4d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.707.0/ward-linux-arm64"
      sha256 "8dd4d8d8523f536f51941af7ab4bf4fc1e631a6da725dcb830f7d33481bc0c69"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.707.0/ward-linux-amd64"
      sha256 "ca5377d18da9d3248f575bf3f18d20b6cbeba1d53ee86aaa04fab818ef1cb070"
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
