class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.791.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/febfa54d-bedf-46f9-8920-36fb685eab95"
      sha256 "d70a1f5f6a1c8868164c84bcc8341e6acf9752bfc9a84814a283b4fcc1b770e7"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/f12f1d1e-b7ec-4f45-a7d5-797cd7543e5d"
        sha256 "34091483b8db1c70937d9a5c55358e073bfa39259b6f7f015fb29943464368ee"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/048d04e7-6471-41ec-9424-1f30b44372cf"
      sha256 "8cc20392776b0eb71890758204d1501d8375255395b1091d5d3c383e5be73570"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/49fc2d40-e0d4-472e-a134-cdee75d29030"
        sha256 "91febbb51f478fb4adaed39cda71c19d40e50c5f2b1e4f3580e4e24b4efebaee"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/f12f1d1e-b7ec-4f45-a7d5-797cd7543e5d"
      sha256 "34091483b8db1c70937d9a5c55358e073bfa39259b6f7f015fb29943464368ee"
    else
      url "https://forgejo.coilysiren.me/attachments/49fc2d40-e0d4-472e-a134-cdee75d29030"
      sha256 "91febbb51f478fb4adaed39cda71c19d40e50c5f2b1e4f3580e4e24b4efebaee"
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
