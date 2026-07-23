class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.793.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/d4ecaa52-abe0-43f1-9d1b-0a4644783c43"
      sha256 "03dc0d7b6551a2855d07a106b17f5a88ebc8385fc786e32bcb9cf4bf1256bb48"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/d92cd560-e479-4a17-9b52-2f41927b43c0"
        sha256 "2f574df49f05cb5e675dceb7fe69b0a02c36a36ea2b605dfd691be3959f42696"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/4e97ddcd-5e44-4dd8-b546-c2eb6b31da4a"
      sha256 "81347cb69d2191265a95af3a0993589899d0afc93cd3459573ec00b378e274bb"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/bcd06d4f-9b1b-4ff0-9cdb-12a435f7cbef"
        sha256 "c86271a75fe9513866441156cb3c6d4c4dc7c74e949e80b314500ceaee76c67e"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/d92cd560-e479-4a17-9b52-2f41927b43c0"
      sha256 "2f574df49f05cb5e675dceb7fe69b0a02c36a36ea2b605dfd691be3959f42696"
    else
      url "https://forgejo.coilysiren.me/attachments/bcd06d4f-9b1b-4ff0-9cdb-12a435f7cbef"
      sha256 "c86271a75fe9513866441156cb3c6d4c4dc7c74e949e80b314500ceaee76c67e"
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
