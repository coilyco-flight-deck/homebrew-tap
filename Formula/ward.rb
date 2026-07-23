class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.798.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/93b18504-3507-42a1-b602-3463430e0f4f"
      sha256 "85a9304be4d2678c25cbb3d7cbfc849f4aa20bbc3eb690a44dc185441424417b"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/670859d8-74d7-412b-bd34-81c3255a78f1"
        sha256 "cf01abd76e3c18cd5264aa7f9a2c8ff1367b424c1331d11888f1a69cb0a4bd84"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/92cc5858-d097-4bdc-9ee1-750bc712767d"
      sha256 "25f02041cdaa3e00c2fb8f35d4d1f5fef8e72e16ea96a2ce29a5d16fe4ab1c1a"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/dc0cef99-00cc-4eb4-854d-ae8c8f3b359e"
        sha256 "7aff85e3d56a5c712e02ffc91be5fea311d71288b9fa46c3e3b7cde963989d97"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/670859d8-74d7-412b-bd34-81c3255a78f1"
      sha256 "cf01abd76e3c18cd5264aa7f9a2c8ff1367b424c1331d11888f1a69cb0a4bd84"
    else
      url "https://forgejo.coilysiren.me/attachments/dc0cef99-00cc-4eb4-854d-ae8c8f3b359e"
      sha256 "7aff85e3d56a5c712e02ffc91be5fea311d71288b9fa46c3e3b7cde963989d97"
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
