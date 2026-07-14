class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.691.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.691.0/ward-darwin-arm64"
      sha256 "598cd586fc5f971f13c03e6aad82bfeb6efd515e763978331591e49113a1c811"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.691.0/ward-darwin-amd64"
      sha256 "a4adfe3107fc5fb88343fb229bb4e9c85f2abe2a48992ec46de74f949eb46e4f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.691.0/ward-linux-arm64"
      sha256 "4d2535709f102f58b586c4250ca911b7206d151cad5f69a1d58b2ddd362f3447"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.691.0/ward-linux-amd64"
      sha256 "2ac95ab1a7f92cc0eed4fb4926cb78e4be282dcbbcd308fd772b79ac87249baf"
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
