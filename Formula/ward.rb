class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.789.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/7aa2a2e2-7521-4e9e-8cb1-36fc20c7a033"
      sha256 "188cc7b1e692d6fa55d259e3e904755f5e78d8b7a1eda932bfe0a58227917006"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/1694c078-03f2-4299-a40f-bd4dee7f04c8"
        sha256 "0023285c4d8f942601051f2f5a2f08b6b7382068642598d82184946f1f240db5"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/f172ef6f-38dc-4ca9-8df2-8284176e8a00"
      sha256 "b8dbc223406c91b53772e5a11d3205d1b85deed8905a5ec0e339f3d4e853dc40"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/aa6ab763-ff25-41bd-b673-c5a59112b4fe"
        sha256 "c47b183e7aa9fda4046387549b9c37b2700807263ed3f23bf186715152e94d9a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/1694c078-03f2-4299-a40f-bd4dee7f04c8"
      sha256 "0023285c4d8f942601051f2f5a2f08b6b7382068642598d82184946f1f240db5"
    else
      url "https://forgejo.coilysiren.me/attachments/aa6ab763-ff25-41bd-b673-c5a59112b4fe"
      sha256 "c47b183e7aa9fda4046387549b9c37b2700807263ed3f23bf186715152e94d9a"
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
