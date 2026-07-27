class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.820.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/e76f233a-e4e6-4075-86a4-c2f6be4c452d"
      sha256 "70b424494fbfa918c68c14ec1e8d785779b3df498e712e47d067a0b7256bdc25"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/eb545e1b-bb9a-4a9e-97f8-a3367a0db48c"
        sha256 "0317c1a9d998b9daa6a7c20b17ab7fbe9f4afc046f9361a6a6b98faf4244f295"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/554dd036-5240-41aa-b33e-98c57619d27b"
      sha256 "538d573251acb101448bc23a0edb057ae871cecfcebbd56dd190f1bf83512d11"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/c069554e-98f6-444e-9b8c-0231f3040758"
        sha256 "27237f5ccb641fe6f7d51721f8854cf6617ae29382fbeeb17a84a6d421977af2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/eb545e1b-bb9a-4a9e-97f8-a3367a0db48c"
      sha256 "0317c1a9d998b9daa6a7c20b17ab7fbe9f4afc046f9361a6a6b98faf4244f295"
    else
      url "https://forgejo.coilysiren.me/attachments/c069554e-98f6-444e-9b8c-0231f3040758"
      sha256 "27237f5ccb641fe6f7d51721f8854cf6617ae29382fbeeb17a84a6d421977af2"
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
