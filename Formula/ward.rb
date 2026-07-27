class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.822.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/8a708502-6d2c-4a51-95fd-78e5e1a0a5e8"
      sha256 "02b6685dc89d813c153de32f115397cd93a5c4e8b2b4fe929e8a0a9d51d49574"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/1b51f932-8a75-49a8-8cf5-66dd7d86a17d"
        sha256 "94995e58504d9d8e6b878a702da774a82b2e9005e2149457b1c393ba13252ecd"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/c74cfa24-7531-4dc4-8fd7-45ebc94ceae8"
      sha256 "3a057574e31de471bc841b1d8797466a4b8843b362551131b51e98785f6a7b60"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/95fe0249-56bc-4543-8ea7-c0f5a428a106"
        sha256 "1f1f8981cbe47cfc8f911e8e2a3937157d71075ca68ab6ac7e4aa8aa236741a5"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/1b51f932-8a75-49a8-8cf5-66dd7d86a17d"
      sha256 "94995e58504d9d8e6b878a702da774a82b2e9005e2149457b1c393ba13252ecd"
    else
      url "https://forgejo.coilysiren.me/attachments/95fe0249-56bc-4543-8ea7-c0f5a428a106"
      sha256 "1f1f8981cbe47cfc8f911e8e2a3937157d71075ca68ab6ac7e4aa8aa236741a5"
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
