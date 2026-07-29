class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.860.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.860.0/ward-darwin-arm64"
      sha256 "550b781e3dfb2bdbd12b0a559dfc1538ee767665782c8ba1ebc35eadec661502"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.860.0/ward-linux-arm64"
        sha256 "3bce42428f925e68ca41d29613ee713f0a4591ec732dbe548dd61b8682eb100f"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.860.0/ward-darwin-amd64"
      sha256 "4a2e4b7de19959c9760849d66312048bd375bd5a85eafe11d69f5ef8591a751f"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.860.0/ward-linux-amd64"
        sha256 "fdaed40c8a87424dba12f4ebdb17ed84987eff16f0b7493703d29c1995d5a262"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.860.0/ward-linux-arm64"
      sha256 "3bce42428f925e68ca41d29613ee713f0a4591ec732dbe548dd61b8682eb100f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.860.0/ward-linux-amd64"
      sha256 "fdaed40c8a87424dba12f4ebdb17ed84987eff16f0b7493703d29c1995d5a262"
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
