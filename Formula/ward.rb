class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.746.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.746.0/ward-darwin-arm64"
      sha256 "fc82ab03645afe9e88074cfb11309df07ade8f0a7a65415e30676d58ce6d1066"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.746.0/ward-darwin-amd64"
      sha256 "3c897e1135aef48180053756158b3ccfb55ad85bda7292ebf8faeae1517f1871"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.746.0/ward-linux-arm64"
      sha256 "79ffaad8f59f0fb80c1ddfa0f823241c4cae832296b3e4c8770cd76c89107ac7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.746.0/ward-linux-amd64"
      sha256 "33fc8a2f88e41a0b1f984117b19fba7e6d863b56eee4e24f8f375dfebd44d8fb"
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
