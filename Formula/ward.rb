class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.525.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.525.0/ward-darwin-arm64"
      sha256 "b93b72e2bcb4abf544954bef34abd27a0573a062ca656d7979a1e652b183a85e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.525.0/ward-darwin-amd64"
      sha256 "8042ca4f2f49f8eed086d256e0b985f3e1580b8ed17aa0567d0808d4a524a181"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.525.0/ward-linux-arm64"
      sha256 "4eb4b58e5d87f009ff9469bad6847c962b4d4f93014158f48ceae9a20f8bbf27"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.525.0/ward-linux-amd64"
      sha256 "1ea03813aad157737ef3a291c8b4cd4c14f9c6fa863a3a32868094e6094093bf"
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
