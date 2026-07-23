class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.795.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/077cc5d2-d2e6-4b44-b9a9-0a36d73aa123"
      sha256 "a0c23c42fc87267cc6557ac6bb7f425778c599cd2c68f50490a306c1d0b86a5b"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/28c13f65-21e1-4357-bb86-b223ced66785"
        sha256 "b9afd35a99f5a40e5b300b3f70db2dde9fd4435758c23a6acb55788f1df98f20"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/5c4aa200-2042-4831-b397-185a44d5688d"
      sha256 "7ce5eba3da8daf2a42bf79583691f30c30f24aa9f431fcb4aaee6614faa229af"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/1e990211-c85b-48bf-bafc-696f691cd62e"
        sha256 "c3e09ad314a464d676ab0bcd434af33c76b0e5594b341774c26a611ec1974db3"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/28c13f65-21e1-4357-bb86-b223ced66785"
      sha256 "b9afd35a99f5a40e5b300b3f70db2dde9fd4435758c23a6acb55788f1df98f20"
    else
      url "https://forgejo.coilysiren.me/attachments/1e990211-c85b-48bf-bafc-696f691cd62e"
      sha256 "c3e09ad314a464d676ab0bcd434af33c76b0e5594b341774c26a611ec1974db3"
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
