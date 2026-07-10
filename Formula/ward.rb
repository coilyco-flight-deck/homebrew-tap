class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.559.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.559.0/ward-darwin-arm64"
      sha256 "76bed1dfb272e087bb8ce99bec47070236c186b1f134d54a45db843927d90b50"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.559.0/ward-darwin-amd64"
      sha256 "5a24109330ff94a58d493c06ed630d72f3bc0b6d86fc89247f32b6de0cba208f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.559.0/ward-linux-arm64"
      sha256 "a4fb50ab2241382ed39e2d6708c005e5a15b2dfeb5672d599490db67ea595da3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.559.0/ward-linux-amd64"
      sha256 "187681cfd7cec7579a9410e5e11014bcdd8cd2c26fcdae75fb8014982ea5ba67"
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
