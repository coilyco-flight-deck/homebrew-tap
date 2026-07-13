class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.641.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.641.0/ward-darwin-arm64"
      sha256 "a223acc5d889d7fdf7aac952ff3db935d7427ce043eca5a3ec16990bd8100802"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.641.0/ward-darwin-amd64"
      sha256 "4c7db3a9fc5b53824db37e81673124deb09d562e670d43fcd537f778560dc400"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.641.0/ward-linux-arm64"
      sha256 "61e46f9c406fbf31484e5ce88edf5356bc1f678121d0d7308119f7005b1b6ffa"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.641.0/ward-linux-amd64"
      sha256 "89dcf18e2b9649b89ca950df4b50fe3e69b379fe173ab0a075ecd429f7906934"
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
