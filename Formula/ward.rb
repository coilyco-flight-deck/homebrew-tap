class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.543.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.543.0/ward-darwin-arm64"
      sha256 "d663080f8eba21d9ba657a9224f69c903af1bb8db94b0519f08ae0d83f083a15"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.543.0/ward-darwin-amd64"
      sha256 "b47fd57828cf38e089a5742d233186d628df50ae1a30d0c3ca3f1171e5919998"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.543.0/ward-linux-arm64"
      sha256 "e778eb9b5ea81dff56e7c4e1690e4027e450b7556ff2e7ed64724931495f67a2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.543.0/ward-linux-amd64"
      sha256 "84e63881cb4077edf14aafe8476206dccc18707f5dc5d0e27da49502d8896468"
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
