class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.708.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.708.0/ward-darwin-arm64"
      sha256 "68caae7a087f7e0a3c7be4dc53240dcb490f38f5564bc342472b666c69377922"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.708.0/ward-darwin-amd64"
      sha256 "20e77c4934444e93f2c34559dee215b45920d93a5f6fcd80492ccf8b2ced0fbe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.708.0/ward-linux-arm64"
      sha256 "31e3e8698b081c81331c87022f20d094c73c6b3fef12a39440fbfad94ba0b154"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.708.0/ward-linux-amd64"
      sha256 "ef0690916c333de1a10f2905c7f6e3e77f148feafc447dce6da0b37b32427b7f"
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

    bin.install_symlink "ward" => "warded"

  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
