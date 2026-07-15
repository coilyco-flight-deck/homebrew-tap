class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.742.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.742.0/ward-darwin-arm64"
      sha256 "0680dd40c286a9cad2c1fb342f4369a17694895dec624ac4e93513c45eed7bbe"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.742.0/ward-darwin-amd64"
      sha256 "1a42f8c6fa7b18e04fcfa400afea05f847a09a8faed080d1293777bf2f1fde5a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.742.0/ward-linux-arm64"
      sha256 "149641f4194d8db2293907bf74c2fba4ab45b3d2a43a3d9e5b5e062b6ae8f2ed"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.742.0/ward-linux-amd64"
      sha256 "7331f15b13d6908f5a889a45b22a443f1b2427049496e9d3a43445a71a49d1b4"
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
