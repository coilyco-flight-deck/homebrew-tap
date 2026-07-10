class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.596.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.596.0/ward-darwin-arm64"
      sha256 "1de99f0a34133682b332fd156fd66be646aa2f393aebf59ae03302045ef83bf7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.596.0/ward-darwin-amd64"
      sha256 "45f8730e67e1b59c597d9cf4cea501d6341270bb14f1ddcd207ee3a9ad57c7cd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.596.0/ward-linux-arm64"
      sha256 "7ed9434b2e8ce829b4437c6f6403f09f23e801cc333c37d57b2f4d0659b0c7ab"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.596.0/ward-linux-amd64"
      sha256 "aac39c0838c068e2a370e1c41ff81b75f6eb9a8b7b40e09fc64b6499a84bd05f"
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
