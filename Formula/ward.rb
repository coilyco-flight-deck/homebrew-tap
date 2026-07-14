class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.677.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.677.0/ward-darwin-arm64"
      sha256 "29f28e771bcd98378a3a8660e6da943d68e15a6c2ef0cfe8d8d4ae7f25614c83"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.677.0/ward-darwin-amd64"
      sha256 "30226ced6b3735d381a9b148eba089f5372e6707e582c90269b2babc176a8163"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.677.0/ward-linux-arm64"
      sha256 "53b8735a12e454634dac27eaefe547775a8b9b196ab41a7a57fac32e6c9e9a41"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.677.0/ward-linux-amd64"
      sha256 "5a9e5033305e8c2c80af0c408006da54201f2ab0eae3dd894c412b1cb6719d1e"
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
