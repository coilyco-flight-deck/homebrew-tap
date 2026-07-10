class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.593.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.593.0/ward-darwin-arm64"
      sha256 "0832c4b00219267ed28baac88dfe258e9424132dbe0c9661c76cbc40c8dbf831"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.593.0/ward-darwin-amd64"
      sha256 "1463238e8a08f6e58297e8be4b99b77143ec0a3a1827589279b9e0b1d26c3031"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.593.0/ward-linux-arm64"
      sha256 "509d5742b95bb46c755485e5f2c764239d2f445bd8adeb49b9074c96ee3495d6"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.593.0/ward-linux-amd64"
      sha256 "e8316fb42d7ed6cd336ba442d25c06583ea5d871b3eb794bfc1f2e18ef792d69"
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
