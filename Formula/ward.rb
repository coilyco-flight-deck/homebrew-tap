class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.864.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.864.0/ward-darwin-arm64"
      sha256 "e5dda4f23a6621a96a6ff9881b7f80d132cda715043c13293b786666bda05697"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.864.0/ward-linux-arm64"
        sha256 "fe9f9d09f6c4b58aa9d25dbee962b3305e30a16e2f9cb92ac9c02c56e8824cf1"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.864.0/ward-darwin-amd64"
      sha256 "d5fa7b695a43d1a911824a93dd1255f3c597e39c7211e06c128082260d4cca4e"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.864.0/ward-linux-amd64"
        sha256 "ed4bafb970c5354d4df4b86c45b3ee3b95b6399afc3efc90854ccdb9e697a406"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.864.0/ward-linux-arm64"
      sha256 "fe9f9d09f6c4b58aa9d25dbee962b3305e30a16e2f9cb92ac9c02c56e8824cf1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.864.0/ward-linux-amd64"
      sha256 "ed4bafb970c5354d4df4b86c45b3ee3b95b6399afc3efc90854ccdb9e697a406"
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
