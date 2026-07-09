class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.516.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.516.0/ward-darwin-arm64"
      sha256 "67a1a97bc801ed521fe384e98cee475a6c38d1fef59f8d049fef1c06f91c0d95"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.516.0/ward-darwin-amd64"
      sha256 "36e4b5824487fa3f81dc3161c74f4d8ca5328e07bf7725b411cf5fff69ab3f07"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.516.0/ward-linux-arm64"
      sha256 "16604be6077e8ac39bf9b882475de32dc2c31d12de8a597462d3bffb5b2497d8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.516.0/ward-linux-amd64"
      sha256 "4d6f3ba02144060054df2aef4294b8230dd8687df232753d860826e0d0b90326"
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
