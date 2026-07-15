class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.718.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.718.0/ward-darwin-arm64"
      sha256 "a74bb4c9cad6e84d26561babd8436df9a11304f74b47eeb0dcc978ea687a3487"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.718.0/ward-darwin-amd64"
      sha256 "a1c418f5bb90c06d26036012d14470bd8c0ab45cd19f02dbc09ef4e61082ea5e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.718.0/ward-linux-arm64"
      sha256 "96a01822180de9b68ff6c3f238de152eb726ceb12c7ce03b86800999e3d15a15"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.718.0/ward-linux-amd64"
      sha256 "107cc22736dd98fd150daa42a238c977771fdff8c4493ec1244152ea3941d916"
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
