class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.473.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.473.0/ward-darwin-arm64"
      sha256 "f8e67e260ae04c0438483736ab725d5db859bb3797f519e27dd6fd78bc7f18c3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.473.0/ward-darwin-amd64"
      sha256 "b0f82ed64fad04fd8b15cc43138b94d778ae7c3c826b69bfc8c31f8f4fded0cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.473.0/ward-linux-arm64"
      sha256 "a48139bab14d78f61af27d80713f6dddd17f8b66c3bf06e6d9bb5a3ade3d78e8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.473.0/ward-linux-amd64"
      sha256 "c998fcd10ddd16ffe7c021f40da79fe8cbec5fce790195953808343cde65521f"
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
