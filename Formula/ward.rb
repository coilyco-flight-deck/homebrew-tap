class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.821.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/ef9ff8aa-eae9-4720-b0e2-b27c9f4860e8"
      sha256 "567a3e478e7251efb0cf7923fe7dd4da3986051d674e4f4adae60dde2b4fb226"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/ea79b536-6e3b-428a-8003-db77a1d66363"
        sha256 "b8b334d8ad293ed193a92bdf03efd31cab6a4c75097f90d93d430ab92c9c6348"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/c2ae717d-1152-43a0-b822-3e185e469889"
      sha256 "b41ed458d7ed81397e79bc8cfa1897117795e8d0eb492c03a7cebadc3d1ea4a3"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/38db0430-4a9c-4a8e-a618-5665f440832e"
        sha256 "93b94f34712641d50639cb81e75698847324bfa4738d12899657ca67ed9d92ae"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/ea79b536-6e3b-428a-8003-db77a1d66363"
      sha256 "b8b334d8ad293ed193a92bdf03efd31cab6a4c75097f90d93d430ab92c9c6348"
    else
      url "https://forgejo.coilysiren.me/attachments/38db0430-4a9c-4a8e-a618-5665f440832e"
      sha256 "93b94f34712641d50639cb81e75698847324bfa4738d12899657ca67ed9d92ae"
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
