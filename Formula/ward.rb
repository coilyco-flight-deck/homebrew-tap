class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.855.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.855.0/ward-darwin-arm64"
      sha256 "0ac5858c5af47937cb96dd8bf1529fdebed7bb5db850e4506c16cacbd4d89486"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.855.0/ward-linux-arm64"
        sha256 "f411e87d2a69c9d95cc0148a99a1ec141692bf5e6c19e0332455339be21771b5"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.855.0/ward-darwin-amd64"
      sha256 "d0783579b8101639bef517c77f90edcf40858cc90c92b4e5d9d2e164ee1ff82d"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.855.0/ward-linux-amd64"
        sha256 "7d16cead43d836101f1e1590a5ab2cfd6b21b8af4e7a4601033a56157ec4818f"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.855.0/ward-linux-arm64"
      sha256 "f411e87d2a69c9d95cc0148a99a1ec141692bf5e6c19e0332455339be21771b5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.855.0/ward-linux-amd64"
      sha256 "7d16cead43d836101f1e1590a5ab2cfd6b21b8af4e7a4601033a56157ec4818f"
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
