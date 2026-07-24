class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.803.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/36572fce-2b25-42de-a111-1f98538bed14"
      sha256 "0e79bc6bb82b09910cd7da7882b273975e6d9d7d302745cd9844d796d511c259"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/640d8776-3ba4-4d6a-b8be-936669e8c811"
        sha256 "ef62fa36a1cff56723216dcb5bbf428491df7d859e39740bb007fb610750bdf6"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/bbda8ba4-9a66-4503-8cb3-0145536b229a"
      sha256 "63e0eedd81da9a430b96644c1765b5994e42d846de167f60469290c4108fd909"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/80a36e73-c739-4f53-a078-0ea4113942d9"
        sha256 "1d9729f9c6a5c504ab737e4a2765884a422c913ff6f3c1c6570d21751245b880"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/640d8776-3ba4-4d6a-b8be-936669e8c811"
      sha256 "ef62fa36a1cff56723216dcb5bbf428491df7d859e39740bb007fb610750bdf6"
    else
      url "https://forgejo.coilysiren.me/attachments/80a36e73-c739-4f53-a078-0ea4113942d9"
      sha256 "1d9729f9c6a5c504ab737e4a2765884a422c913ff6f3c1c6570d21751245b880"
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
