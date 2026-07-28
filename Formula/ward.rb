class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.849.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.849.0/ward-darwin-arm64"
      sha256 "6812405f1a5bfae427ed8b3035a28702e3c4eda0c41247c4bc90804ca092a7be"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.849.0/ward-linux-arm64"
        sha256 "d899e19ad49bac25e4e8efa02e6cbff286de5763b2604180ea64cd1252fe9408"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.849.0/ward-darwin-amd64"
      sha256 "494f24810d2c013e833539345bb2ac82ad465de328e6879b450d262cd9ba9de1"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.849.0/ward-linux-amd64"
        sha256 "639f5f104856caaebc91d1aa9190190ae5ec12f3b6fbb589fbf7717401df2d9a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.849.0/ward-linux-arm64"
      sha256 "d899e19ad49bac25e4e8efa02e6cbff286de5763b2604180ea64cd1252fe9408"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.849.0/ward-linux-amd64"
      sha256 "639f5f104856caaebc91d1aa9190190ae5ec12f3b6fbb589fbf7717401df2d9a"
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
