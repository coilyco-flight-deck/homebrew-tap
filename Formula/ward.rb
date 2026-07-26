class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.815.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/580d2b06-97de-4cbb-be9d-480b411cc591"
      sha256 "f40910da4a833b3c2a5c4cf99b991032ef7e1d8c010960bb7fc1c183b7216e9c"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/5524f5fb-b303-446f-b035-9cb0de459c29"
        sha256 "358e80ad8667abb66ca598c0903d5097b8e8dc01b5e8a7091dac6e941297b794"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/b622aedf-d20c-43c9-85cd-3a606bec3360"
      sha256 "95c5fab632f3f30407dd797a0706bcd6eff470589ef84b5ed4e95f1dabb32d2f"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/820f7e04-a2d4-4e61-96bb-1f046c5693fa"
        sha256 "73d5857448ac994ea53b9d35a25291b0b88fa4a567027d6322bd6ff7cc78b6b9"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/5524f5fb-b303-446f-b035-9cb0de459c29"
      sha256 "358e80ad8667abb66ca598c0903d5097b8e8dc01b5e8a7091dac6e941297b794"
    else
      url "https://forgejo.coilysiren.me/attachments/820f7e04-a2d4-4e61-96bb-1f046c5693fa"
      sha256 "73d5857448ac994ea53b9d35a25291b0b88fa4a567027d6322bd6ff7cc78b6b9"
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
