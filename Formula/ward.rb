class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.490.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.490.0/ward-darwin-arm64"
      sha256 "a80a767783705ec2cec9ba874df3a6f1ce5682b6e4153ae7e57dc77ac9d98642"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.490.0/ward-darwin-amd64"
      sha256 "25f2bec6eb1885c8a57d58518902b38c008f7220f3ae8b16df746e1b954fdeb2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.490.0/ward-linux-arm64"
      sha256 "fd3aeb6345d8a23e99e9cb1ee17b85220032fbe7d8b42b063cff04742ae6984a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.490.0/ward-linux-amd64"
      sha256 "0a4dc84337617378dd1fd25594391013e42c0bdc0e488b66dfd15945018beccf"
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
