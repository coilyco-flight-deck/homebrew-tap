class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.624.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.624.0/ward-darwin-arm64"
      sha256 "5ef9117644249d5a8e5ae200702bae0fdcd2b80d4a1f0d03fc73f043e1a90e97"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.624.0/ward-darwin-amd64"
      sha256 "0f9ae11232e03ef96ec32c92cda6d33b644984f5c5b48d344ee7b0333e1ce4bc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.624.0/ward-linux-arm64"
      sha256 "9b8901e7f7f245d454d644b3fa2da885f00f42de3606dccc8db309657820184c"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.624.0/ward-linux-amd64"
      sha256 "e5898e6470d0d970aaab4a6da919749390972ab6d84e46d1c6ded07320fbd763"
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
