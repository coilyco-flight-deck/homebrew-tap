class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.844.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.844.0/ward-darwin-arm64"
      sha256 "9e8d32b5745175c2e59a2b73b72f95c5b2d0d9fa830d8a0075b8bf481752f18e"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.844.0/ward-linux-arm64"
        sha256 "bd02e02ebd08586ef2e2c88b7d5cdf4abacb7a67e8af7e7a7c870a3889b2b62b"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.844.0/ward-darwin-amd64"
      sha256 "10a4688d9628945efc8afa093af3e4a2dafba77068fbb9f4b3afdfa0daf70591"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.844.0/ward-linux-amd64"
        sha256 "ea1551634f8254e6c4ba5fa3461db19c9906c35157f537646c3c334178eccaa3"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.844.0/ward-linux-arm64"
      sha256 "bd02e02ebd08586ef2e2c88b7d5cdf4abacb7a67e8af7e7a7c870a3889b2b62b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.844.0/ward-linux-amd64"
      sha256 "ea1551634f8254e6c4ba5fa3461db19c9906c35157f537646c3c334178eccaa3"
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
