class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.758.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.758.0/ward-darwin-arm64"
      sha256 "edda5882d927a567791aa99f54303dbc1add39aef8316fcdcdceb2e31b3ab122"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.758.0/ward-darwin-amd64"
      sha256 "1f5f40ceb3c265030076d5f0a8fc4a8bb57e21b60634b20c7dc3c4cc5bf18deb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.758.0/ward-linux-arm64"
      sha256 "1d256c6a3b6eebabf55f33f731d7fd66debdca0a2d38b9979dda4041378882e4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.758.0/ward-linux-amd64"
      sha256 "ecbcacff643ae96e73487a2d950f3335b50377040148368d64881e856b6916d9"
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
