class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.610.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.610.0/ward-darwin-arm64"
      sha256 "c38cec16649a247333f84e4ae3e023e4807f5d301892230a4cced273323a1e48"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.610.0/ward-darwin-amd64"
      sha256 "07eeed800bbe6b941afdcbb3560d0dd82f61b808c488aa1708ed316467187d3d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.610.0/ward-linux-arm64"
      sha256 "33bd3beca7b2a9fdbcd3fa6a80e49dc96393bfb8e3899e1a80abf543f41d0cd4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.610.0/ward-linux-amd64"
      sha256 "567b5a10a29f205e38d6f88b2dd0d57e6ebfff099e2a63298479b81dbe955131"
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
