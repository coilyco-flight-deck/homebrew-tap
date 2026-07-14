class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.690.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.690.0/ward-darwin-arm64"
      sha256 "73c163342673247db45eaf4e2ee0a17f5ca6a550d3de300b4d2164c43fbb7559"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.690.0/ward-darwin-amd64"
      sha256 "e0769404e57096c9f37ff388d0ec600d9892c9f4809906da9c170d0a7fa6569f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.690.0/ward-linux-arm64"
      sha256 "a7c505d9553ce1f1bac75d151ed5cf4f0ccbbe7dcf579e1b74046698b254cd2f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.690.0/ward-linux-amd64"
      sha256 "73dc4a40293883a1248ea2822765eb12e8bf96f41bfd69097a7246876531428d"
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
