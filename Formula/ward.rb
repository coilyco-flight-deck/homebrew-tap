class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.812.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/a289f921-9fe9-48e9-8a0e-1469c7b00db0"
      sha256 "b37103578d4022a41d13cf9b71c0b690a21e113af883a36f9c60b0e7202974c9"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/2a63d6d9-cfda-4350-85b1-b06b4efd07a3"
        sha256 "8a97db64ea8305bad100129bbae2b6f05a9c7828f89648a86fa958dc1a2724a8"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/61fbeb59-4e4e-452a-96ef-fa77aac76b41"
      sha256 "e1c746ec4aa552659681d066794e1a583b3e997be38b638d5b3a9e2efa1689e5"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/887c4f13-f814-4759-89d1-f492654ec1b3"
        sha256 "bcecdc55af97c513be10a6329735517a0ccf0e9511c83ced766f36fca9704512"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/2a63d6d9-cfda-4350-85b1-b06b4efd07a3"
      sha256 "8a97db64ea8305bad100129bbae2b6f05a9c7828f89648a86fa958dc1a2724a8"
    else
      url "https://forgejo.coilysiren.me/attachments/887c4f13-f814-4759-89d1-f492654ec1b3"
      sha256 "bcecdc55af97c513be10a6329735517a0ccf0e9511c83ced766f36fca9704512"
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
