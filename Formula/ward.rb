class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.655.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.655.0/ward-darwin-arm64"
      sha256 "9fdae2d4510c275af265a08308589bcd50e19a574795d3ca102ba2ac0ca2881b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.655.0/ward-darwin-amd64"
      sha256 "8c18c40f3b541d37610af36e82ce62e617cdd6f6f5c4a74e8134aa3415dae9be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.655.0/ward-linux-arm64"
      sha256 "e2c939d08ce5df84af51e09f69c0c93dc5792ce6b0c521056875525864d428ea"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.655.0/ward-linux-amd64"
      sha256 "41563ddfd3b14f82c6529bbd56a9b094fb154fe8c680ad0bb9a2cfc018dfd1fe"
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
