class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.851.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.851.0/ward-darwin-arm64"
      sha256 "4aaf145482a09f290a25004813f957e2756dd3cedbc11419551f284d05fa4a2a"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.851.0/ward-linux-arm64"
        sha256 "4169c9029334e1379a57a94525fe89d75b3edae6a2d02b39a7f564aaf1f5f246"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.851.0/ward-darwin-amd64"
      sha256 "642fab626daaefc5728579829e24da3925062674e9b7e9cd14e37adf1110d8ed"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.851.0/ward-linux-amd64"
        sha256 "0136e5ce6ec26557ac695b79bdacf0351b00eb328e4db85063cfe85bf3565a5d"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.851.0/ward-linux-arm64"
      sha256 "4169c9029334e1379a57a94525fe89d75b3edae6a2d02b39a7f564aaf1f5f246"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.851.0/ward-linux-amd64"
      sha256 "0136e5ce6ec26557ac695b79bdacf0351b00eb328e4db85063cfe85bf3565a5d"
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

    if OS.mac?
      resource("ward-linux").stage do
        sidecar = Hardware::CPU.arm? ? "ward-linux-arm64" : "ward-linux-amd64"
        chmod 0555, sidecar
        libexec.install sidecar
      end
    end

    bin.install_symlink "ward" => "warded"

  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
