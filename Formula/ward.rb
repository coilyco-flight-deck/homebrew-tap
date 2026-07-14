class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.688.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.688.0/ward-darwin-arm64"
      sha256 "c0a17b9c06bd9c038521d743498faeb6aa4c42b898d165c590bde54348f608b1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.688.0/ward-darwin-amd64"
      sha256 "7e9d3ce280fbf54f3a14e1d7bc2041bd0d588128cbc742d7bce82af38c8b9045"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.688.0/ward-linux-arm64"
      sha256 "eb6d0241b7fae0594efc5cc67838aa45804c614787fb58a567a45605df7ef226"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.688.0/ward-linux-amd64"
      sha256 "4a8baba1cf316ed9ab6a5be6c569083f214a7e5590e3eb9fc5f5e38a08988509"
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
