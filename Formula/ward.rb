class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.854.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.854.0/ward-darwin-arm64"
      sha256 "51eccf0d0b754fffbdfefba6ef5e8650eac0ea05dd4e418372139567afab72ff"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.854.0/ward-linux-arm64"
        sha256 "dfe3a568a9ffd7c89013b1a75bcc5882cea9378b0c83686dbac2e56b91ba50e5"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.854.0/ward-darwin-amd64"
      sha256 "3e48feb145350492efa527936199510d71d313fa672dc948aef7b6337d7607cf"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.854.0/ward-linux-amd64"
        sha256 "912feb9fa37bb5566dbe31de0821a835f2273e7bd9482a34ae3f86fbf16ad81d"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.854.0/ward-linux-arm64"
      sha256 "dfe3a568a9ffd7c89013b1a75bcc5882cea9378b0c83686dbac2e56b91ba50e5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.854.0/ward-linux-amd64"
      sha256 "912feb9fa37bb5566dbe31de0821a835f2273e7bd9482a34ae3f86fbf16ad81d"
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
