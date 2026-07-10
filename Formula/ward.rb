class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.542.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.542.0/ward-darwin-arm64"
      sha256 "6bc447838a5934869344b6a1c4c5779e2b2f05c3a45b174f110b6b35ff72b3a0"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.542.0/ward-darwin-amd64"
      sha256 "eeccbeda3b6496a1d449d0a70bfc871754618f00bd6cd718c1172ba97277735f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.542.0/ward-linux-arm64"
      sha256 "d89587cd7444947aa3085c9042bd3eb865609661cbb92f8cb8764b075c3794b5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.542.0/ward-linux-amd64"
      sha256 "fd2f2d87ab79d4c9339805711aac4d807db3d78490ccfdad23721197862cd9e6"
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
