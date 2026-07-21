class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.782.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.782.0/ward-darwin-arm64",
          headers: ["Accept: application/octet-stream"]
      sha256 "1efc76fd0dc36e2f82f305daa2499a55bdb6bf0b1f28f1cf19af0a015f106965"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.782.0/ward-linux-arm64",
            headers: ["Accept: application/octet-stream"]
        sha256 "813d9dd9d0e69c31671c3b31a4ca64042e3deb2798928e2775d57d7def7f7fd8"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.782.0/ward-darwin-amd64",
          headers: ["Accept: application/octet-stream"]
      sha256 "84aca30b3e1809ca843e1c2ce7c0f29cc96a0cbf0a9d59cbdd1ade479598344d"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.782.0/ward-linux-amd64",
            headers: ["Accept: application/octet-stream"]
        sha256 "9d9bb9fb93ef24880ddbc993dd7a3973736c74c6a3582a3b7eb7e022a4fd8d81"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.782.0/ward-linux-arm64",
          headers: ["Accept: application/octet-stream"]
      sha256 "813d9dd9d0e69c31671c3b31a4ca64042e3deb2798928e2775d57d7def7f7fd8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.782.0/ward-linux-amd64",
          headers: ["Accept: application/octet-stream"]
      sha256 "9d9bb9fb93ef24880ddbc993dd7a3973736c74c6a3582a3b7eb7e022a4fd8d81"
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
