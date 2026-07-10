class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.611.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.611.0/ward-darwin-arm64"
      sha256 "ef8030876ce453196fc039b4ddf3cdd0d4381fe7dee44ee91eb96a2f1d807a4d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.611.0/ward-darwin-amd64"
      sha256 "fcafebddf84cb65f4df48aa90674d9ab37d22597c035f6352c66745381ba74f5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.611.0/ward-linux-arm64"
      sha256 "be68b0d72bcde7b6728af695a4a91c61c8c82b320e733ae75934f46ca355dc30"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.611.0/ward-linux-amd64"
      sha256 "368a2fb03e8bae6f68320fb70787556981877eb4e451664661e86141521ef158"
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
