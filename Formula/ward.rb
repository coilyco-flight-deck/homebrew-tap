class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.665.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.665.0/ward-darwin-arm64"
      sha256 "bccbad7cc786f77313a0e15b33e6f702b71304a48ca36bdad04627eb23849a8d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.665.0/ward-darwin-amd64"
      sha256 "adf92025d7a60b780e5fbd8435a262bfca74f51d19fa82cfaa384c9706537a4a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.665.0/ward-linux-arm64"
      sha256 "75103eb12122857c9961d2d66bef2132c41ff14f1bc3cecdbbd2f8900ec67843"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.665.0/ward-linux-amd64"
      sha256 "7208d83f50bef1fbde87261254fffa034687bbd218438d088d71e3c259975062"
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
