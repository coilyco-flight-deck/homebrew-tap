class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.642.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.642.0/ward-darwin-arm64"
      sha256 "e89401726f3d69129a4ad5d24490a21c3331d5c7f5f3550c490678dc72529841"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.642.0/ward-darwin-amd64"
      sha256 "fafc8d53b3290d7ceccb5b2431643b124a68ec409b420d6f4df689b4af0f1d61"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.642.0/ward-linux-arm64"
      sha256 "98d039331848dd589bde331496fa923f1e4e9ee01b5d2ab76e5f87af0a0b17e4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.642.0/ward-linux-amd64"
      sha256 "6e82ff08adf2650311e1ee525eb39444fe85814fbad353cee8808a1127d6e012"
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
