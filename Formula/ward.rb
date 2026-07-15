class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.721.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.721.0/ward-darwin-arm64"
      sha256 "87dda04914689ca828fe2d0cad32f7e9d0067715bf32ac7fea6847d6d541e981"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.721.0/ward-darwin-amd64"
      sha256 "d1616312e22bfb2585a8ac7be3610ea97fa49b0b20aecf4e0fa7a5034edf8747"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.721.0/ward-linux-arm64"
      sha256 "ac0ffa39a72f44461d5a3d44ba50f862036e2894debad6639e43d72a4077ab95"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.721.0/ward-linux-amd64"
      sha256 "9291f58427608009bdb9a0172863a2bcf9a2f47254a11122e557eaf317733b16"
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
