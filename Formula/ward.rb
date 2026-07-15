class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.730.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.730.0/ward-darwin-arm64"
      sha256 "06292557df4d2c3cb5fa1ad69de580a38072f87394f453262167079ab20dc726"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.730.0/ward-darwin-amd64"
      sha256 "4a2b5b6a67b91d2cca1daec16abfbbf1ac52721d7fe0760c662ccd941ec14e71"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.730.0/ward-linux-arm64"
      sha256 "680845ad9455b093e19e842ed305191224e5fdef27e47111969342fae0b8d157"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.730.0/ward-linux-amd64"
      sha256 "cddb375ea1b24e87a9a602bc73afafe5d9f42ae2a8b75350f5cba03dd6c8854a"
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
