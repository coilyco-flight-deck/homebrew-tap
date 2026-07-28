class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.841.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.841.0/ward-darwin-arm64"
      sha256 "7198133950e3e4abe9c66329dcc4313f6a87599ecf772bcca66733309c6be584"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.841.0/ward-linux-arm64"
        sha256 "938b70fd6ac7ed66e252efff0d958d3ab48ddd8a7ee726f273bd7924f04184e2"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.841.0/ward-darwin-amd64"
      sha256 "c3f4b3cb4996a04cc3c5fd788ea2cafa6d335bb8398a094b8884c042f7598413"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.841.0/ward-linux-amd64"
        sha256 "1cfe1f239169d2f16d006c3f3b4d995743288ed624b4dcdc88116c753488b385"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.841.0/ward-linux-arm64"
      sha256 "938b70fd6ac7ed66e252efff0d958d3ab48ddd8a7ee726f273bd7924f04184e2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.841.0/ward-linux-amd64"
      sha256 "1cfe1f239169d2f16d006c3f3b4d995743288ed624b4dcdc88116c753488b385"
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
