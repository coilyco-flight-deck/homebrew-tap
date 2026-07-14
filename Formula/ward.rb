class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.666.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.666.0/ward-darwin-arm64"
      sha256 "7badbf3fc1334e4b5d30747a4302b9dbf431b76ace5eedf6944c045170d85fdd"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.666.0/ward-darwin-amd64"
      sha256 "cf37186780db93f3035d6c92518860b2c525e34e6d74f1c0e4b17335561d730c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.666.0/ward-linux-arm64"
      sha256 "513c8773add0dd8e85fa7a95ce7aa17b44c25f364a3e3dc99dc2afa2eee11538"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.666.0/ward-linux-amd64"
      sha256 "bac61d06283587eb9cc3ea9f863334fcdc6f14b6de94b792850e8d6b15240615"
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
