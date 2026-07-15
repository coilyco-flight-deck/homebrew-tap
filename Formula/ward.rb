class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.701.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.701.0/ward-darwin-arm64"
      sha256 "3baec24c38d2c206b3fa6b73f3209619213a8aa9ef0659316b2273145a44a730"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.701.0/ward-darwin-amd64"
      sha256 "e71316c515461962f9916a93a3f26340c39376e6ff845c350c4c2ac34d4afbf4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.701.0/ward-linux-arm64"
      sha256 "fa43428c071f0f2c5bf63825bac62340d5dc0005ed806447e9ec62bb284fa63d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.701.0/ward-linux-amd64"
      sha256 "e1f8578bb431f828046229e2cd4fffb7e8eae0dd39ed6a705ae285f00ecf0c05"
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
