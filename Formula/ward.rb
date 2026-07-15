class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.738.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.738.0/ward-darwin-arm64"
      sha256 "5d4bf44afdd5d678871166dd39dade50746918df0a5a8a197757777de951e38d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.738.0/ward-darwin-amd64"
      sha256 "4028d54d81e5d8d328c0ac74ce98e39a44cfb157b8b6f9d1c64480737820a92f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.738.0/ward-linux-arm64"
      sha256 "6151edc5b7c7fe786d8af9c1e7fce15b8c75c1b9a7ce24ac2c78fcdb6d79c497"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.738.0/ward-linux-amd64"
      sha256 "07c058a73032b42818dcc104188e1f900023f8fb7835dfbd67751dae9fe8d751"
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
