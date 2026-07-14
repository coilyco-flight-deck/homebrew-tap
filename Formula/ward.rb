class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.674.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.674.0/ward-darwin-arm64"
      sha256 "b07391cbc6ef4b26886cef88906229290c5f82a92acdc36050daf24e9b47550f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.674.0/ward-darwin-amd64"
      sha256 "a37fd84b43f59a99139bc731b07f392edff61a11454566deb6dfdc10b9e0d177"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.674.0/ward-linux-arm64"
      sha256 "68460eb8bf923d129fbb580a60904fc3482051adf8b447f088b5b5a599f4cf9a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.674.0/ward-linux-amd64"
      sha256 "24ab6f09b8d17c7c78a8f0d9f8019807c95a303ca5bd46ec8c138ff103bb7874"
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
