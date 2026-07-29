class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.859.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.859.0/ward-darwin-arm64"
      sha256 "0eb997b75bba1394c5edabecba95ffee88c8958edf54c08ab452a923521ea16f"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.859.0/ward-linux-arm64"
        sha256 "21a37959a1c311a8c6484156c9a87dff23fd8fc341365df5f75d214d33c3ad44"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.859.0/ward-darwin-amd64"
      sha256 "f605dac180a99d396f534b51a0ac83c9ee4bc96d580136e425deff281788807f"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.859.0/ward-linux-amd64"
        sha256 "5abe96f3ee26e4d3df0713099f1c92a2e3ac2962ad55c291a7b0af05d1dc13a6"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.859.0/ward-linux-arm64"
      sha256 "21a37959a1c311a8c6484156c9a87dff23fd8fc341365df5f75d214d33c3ad44"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.859.0/ward-linux-amd64"
      sha256 "5abe96f3ee26e4d3df0713099f1c92a2e3ac2962ad55c291a7b0af05d1dc13a6"
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
