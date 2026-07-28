class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.853.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.853.0/ward-darwin-arm64"
      sha256 "a59a5049e8eb0cbae04d80ae0571900da4390369364d39d562861bec39579629"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.853.0/ward-linux-arm64"
        sha256 "78524cc2bd15236a75804fd292460546c5b15b9a185d84095cc1604f43ac1e16"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.853.0/ward-darwin-amd64"
      sha256 "0ade55f8857d95e57f12185622d97f30d42b2c2991530c2dd2296d4bd3ef41b4"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.853.0/ward-linux-amd64"
        sha256 "0c7aef9b9d4c598d89f402079a62244c28e167380344e273c388fd611763d052"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.853.0/ward-linux-arm64"
      sha256 "78524cc2bd15236a75804fd292460546c5b15b9a185d84095cc1604f43ac1e16"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.853.0/ward-linux-amd64"
      sha256 "0c7aef9b9d4c598d89f402079a62244c28e167380344e273c388fd611763d052"
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
