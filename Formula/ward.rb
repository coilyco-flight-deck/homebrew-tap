class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.781.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.781.0/ward-darwin-arm64",
          headers: ["Accept: application/octet-stream"]
      sha256 "94921932b6f6313e689b274575db1282f39e9407ce4d080ccf452c41500d6fd7"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.781.0/ward-linux-arm64",
            headers: ["Accept: application/octet-stream"]
        sha256 "7b2c17e90e550efb58411135c144efade2ee69fc1b9d706400199a751b0a4651"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.781.0/ward-darwin-amd64",
          headers: ["Accept: application/octet-stream"]
      sha256 "e719fc23d2c79aa70dbf9c0c676b0c8f8e4121fab063eaaf59b2dbd3cc3de768"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.781.0/ward-linux-amd64",
            headers: ["Accept: application/octet-stream"]
        sha256 "f1707e0041f2caceefb6c5eb54d61426ce9c5df12e8f35ecbc21348acc1551ec"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.781.0/ward-linux-arm64",
          headers: ["Accept: application/octet-stream"]
      sha256 "7b2c17e90e550efb58411135c144efade2ee69fc1b9d706400199a751b0a4651"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.781.0/ward-linux-amd64",
          headers: ["Accept: application/octet-stream"]
      sha256 "f1707e0041f2caceefb6c5eb54d61426ce9c5df12e8f35ecbc21348acc1551ec"
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
