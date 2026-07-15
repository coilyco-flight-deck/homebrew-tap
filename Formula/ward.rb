class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.697.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.697.0/ward-darwin-arm64"
      sha256 "b4709fb46a44865ed927087c3611d9a6f7dccf06c2ea9f2f9c5c5694ba0fda80"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.697.0/ward-darwin-amd64"
      sha256 "b32a52ece0991527eebf3cfd2211a9df62cd21da358b7079c7f0ddda25d63e2a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.697.0/ward-linux-arm64"
      sha256 "3cf9d91de51d5d1c8ccdb937f90d37ebef3d9b9de51c30a06dcd15d975e52ece"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.697.0/ward-linux-amd64"
      sha256 "cd3f173b1eff4064b095f157ae6615845ac5a5bc5e533c6fe08f6ddd6a38eab8"
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
