class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.805.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/d2ff1684-633c-4bab-85f3-56aa03f430ee"
      sha256 "00f1b11e61b0a662d0330e6efe1833a355d32851d0a5a1958e5d0bebc3783b69"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/0fb7b2aa-cdfb-4829-b861-cbd035f5e493"
        sha256 "2f6c51dd0c60a47994b5fb8240c4a76e19e9a92e0694d6ff014a65cbb1ad4917"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/8c2f96bd-53b2-46e7-ad27-15123f697602"
      sha256 "fc5e828df1fe84ed1001488a93b5b298af26d1c9634789bcb934433582e4aaa2"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/7d0ebe88-ed5b-4b60-9690-df2fd7c0be1a"
        sha256 "8617279be0869303d2ad594fd3e6d41af9f8b1bd50d29b0f1bd22b2ea367a9dc"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/0fb7b2aa-cdfb-4829-b861-cbd035f5e493"
      sha256 "2f6c51dd0c60a47994b5fb8240c4a76e19e9a92e0694d6ff014a65cbb1ad4917"
    else
      url "https://forgejo.coilysiren.me/attachments/7d0ebe88-ed5b-4b60-9690-df2fd7c0be1a"
      sha256 "8617279be0869303d2ad594fd3e6d41af9f8b1bd50d29b0f1bd22b2ea367a9dc"
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
