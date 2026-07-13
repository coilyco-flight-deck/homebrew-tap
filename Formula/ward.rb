class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.632.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.632.0/ward-darwin-arm64"
      sha256 "dffd64fd55607f85986632cd9183c5ba8a1d1fd53e3386bf914956de49b5d4fc"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.632.0/ward-darwin-amd64"
      sha256 "ffeb854982a5c91f120152bbc707b81b57de95e75d4ac262f06d852679a71ab2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.632.0/ward-linux-arm64"
      sha256 "f48040144013c50d427c05dc990e8d977d0c87add5cf06861ae1444e0b02c3c8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.632.0/ward-linux-amd64"
      sha256 "c35430726bdffa7ad2da99b5a09b32bee6197c22abbf55b1ae98b2c25711b15c"
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
