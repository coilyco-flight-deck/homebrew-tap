class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.852.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.852.0/ward-darwin-arm64"
      sha256 "654b4149dbf9374aaaa9c90402f0204f5f0ca5407ae20cbcff15f83f594a3db6"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.852.0/ward-linux-arm64"
        sha256 "a0f8e29cf4d194987675840056e6f727287b5efcaba53e27bd6a7cdc3f628b55"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.852.0/ward-darwin-amd64"
      sha256 "a83316faf5d26e171e619b5a41cb098d3c12fb45cb4ad81f246a864a04b880b8"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.852.0/ward-linux-amd64"
        sha256 "a37a4e47f1f78a9bbb656574baf42cdda4aaa2aa2e52701a9bbd46f2f61be6e2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.852.0/ward-linux-arm64"
      sha256 "a0f8e29cf4d194987675840056e6f727287b5efcaba53e27bd6a7cdc3f628b55"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.852.0/ward-linux-amd64"
      sha256 "a37a4e47f1f78a9bbb656574baf42cdda4aaa2aa2e52701a9bbd46f2f61be6e2"
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
