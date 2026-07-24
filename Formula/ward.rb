class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.802.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/427e4fd1-5ea5-4242-9537-d5328f84e862"
      sha256 "45751fc81c49f5fd2baa67b53f41ee6ef7f73ad41a196da3d6b4fe50e182cb46"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/b0572f54-c2ac-400a-93f5-e11116b31388"
        sha256 "1cd2c9dcfe9c9cd38e2ad8cb84d9f61aeb253e157f01d7f9583d6618c973b91d"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/7f926db9-5277-4039-91d8-2239bcfc97e2"
      sha256 "d873e749fc04fe1f6a8d9e092852693874b25f98427938a2af604555a339cff6"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/a83992f5-bbba-4a58-b005-9d57e19d398a"
        sha256 "353bd30caa7f76000a76b95e7f36e816ba3c1c9ecea8aa1767f316a901332fbf"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/b0572f54-c2ac-400a-93f5-e11116b31388"
      sha256 "1cd2c9dcfe9c9cd38e2ad8cb84d9f61aeb253e157f01d7f9583d6618c973b91d"
    else
      url "https://forgejo.coilysiren.me/attachments/a83992f5-bbba-4a58-b005-9d57e19d398a"
      sha256 "353bd30caa7f76000a76b95e7f36e816ba3c1c9ecea8aa1767f316a901332fbf"
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
