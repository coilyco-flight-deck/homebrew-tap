class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.602.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.602.0/ward-darwin-arm64"
      sha256 "6c604d1ff86571c59eb7534e765a31664eb50f967ad0f049e5e9d833dbfdd285"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.602.0/ward-darwin-amd64"
      sha256 "a05edaf084dce859006a07e36bc1e1549cb20a903fd4ef2eb9e0458519aa1be2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.602.0/ward-linux-arm64"
      sha256 "36c6a94e63bc9435b6b1ae328b5a2aa1a934b74b14676245746c343eca78f283"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.602.0/ward-linux-amd64"
      sha256 "d0f543f4f24add5047639806af198f928f3919ac38b8d6ec2c43508351b0efd3"
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
