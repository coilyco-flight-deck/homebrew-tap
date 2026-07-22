class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.787.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/bd41cedf-a51d-4f48-95f5-21729c9a7b2b"
      sha256 "abe411dd20e66597b436301b07349593025b04930933e52f77cd8f5a96ef80fa"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/d411675d-fbd2-4970-ae09-5fc45f08183c"
        sha256 "19ba2e98f1529d86fb7784400ca324e49b8e563cd414756b68e4270e4627df93"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/01dbbe8c-3c3d-40a9-b5d4-4f4c581a0035"
      sha256 "fe4533f72acf38b0638c586e0039bfc810635577ccf02cf597e95f22de11802c"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/a287ece7-add3-4eae-b524-1be84196b14c"
        sha256 "2aa3e48234cd57e00255e03fe2ca0c15d938f975aa57c367b8593f2ef24908dc"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/d411675d-fbd2-4970-ae09-5fc45f08183c"
      sha256 "19ba2e98f1529d86fb7784400ca324e49b8e563cd414756b68e4270e4627df93"
    else
      url "https://forgejo.coilysiren.me/attachments/a287ece7-add3-4eae-b524-1be84196b14c"
      sha256 "2aa3e48234cd57e00255e03fe2ca0c15d938f975aa57c367b8593f2ef24908dc"
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
