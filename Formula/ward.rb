class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.817.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/7db5aaec-c9e5-4dbf-9679-c35eb13672ec"
      sha256 "ff7a735f4103af4f4267b31e6738baedfcd5058a88e87c7b712a68f90ca32f79"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/cbe08264-dd4d-430c-830a-77892953b31b"
        sha256 "5188cacb6aef67c030d80378d059467542b25b97c3bcbc494240ec1ed4d9a28a"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/d675060b-fc2a-4700-8697-d7ec0a0ddda5"
      sha256 "6f896738a9c1e6f73ed6275162daf9dc4425045613b4a893d7bdd0848b2484b5"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/58104aa4-babf-4e95-b782-da3ac7c6a700"
        sha256 "d087ac09180f8114a48cef2c153cdeded8fd8b8895bc3ad1bb214ca7687d0c07"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/cbe08264-dd4d-430c-830a-77892953b31b"
      sha256 "5188cacb6aef67c030d80378d059467542b25b97c3bcbc494240ec1ed4d9a28a"
    else
      url "https://forgejo.coilysiren.me/attachments/58104aa4-babf-4e95-b782-da3ac7c6a700"
      sha256 "d087ac09180f8114a48cef2c153cdeded8fd8b8895bc3ad1bb214ca7687d0c07"
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
