class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.856.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.856.0/ward-darwin-arm64"
      sha256 "1deb57ee9faf23fff1750cc594cdda9e294eb080f3f0ac5081fa834f434eb95f"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.856.0/ward-linux-arm64"
        sha256 "6b786f521d3f1be506c26b8f1d9cf70ec4195f5f058867c7ec7e19af08d90b37"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.856.0/ward-darwin-amd64"
      sha256 "9566a0f535e992fef2e33c7eeafe4333ebd2b35cd3157a07512978431c4e503c"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.856.0/ward-linux-amd64"
        sha256 "e609c46b87fbb4f53af6e73727c0fb756654e5695f9ef6dede532c5a15446fbb"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.856.0/ward-linux-arm64"
      sha256 "6b786f521d3f1be506c26b8f1d9cf70ec4195f5f058867c7ec7e19af08d90b37"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.856.0/ward-linux-amd64"
      sha256 "e609c46b87fbb4f53af6e73727c0fb756654e5695f9ef6dede532c5a15446fbb"
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

    if OS.mac?
      resource("ward-linux").stage do
        sidecar = Hardware::CPU.arm? ? "ward-linux-arm64" : "ward-linux-amd64"
        chmod 0555, sidecar
        libexec.install sidecar
      end
    end

    bin.install_symlink "ward" => "warded"

  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
