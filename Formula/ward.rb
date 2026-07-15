class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.716.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.716.0/ward-darwin-arm64"
      sha256 "c6fd50c55e01e69d0618cdbfa069b68d1f0b9435174a3608501396557a0eee3b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.716.0/ward-darwin-amd64"
      sha256 "1063116693a766984ddff344c48e698301c468bc2c42b95a32a278eae3aff172"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.716.0/ward-linux-arm64"
      sha256 "4d35d6d485cda5f81994e55ebef0aa9d98283d0f298f2ba6176d552ff74b44df"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.716.0/ward-linux-amd64"
      sha256 "3006e6eeaa6e2a35fa0e2a4ded72b84b24539dcaabf81692458daa8f83e04b34"
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
