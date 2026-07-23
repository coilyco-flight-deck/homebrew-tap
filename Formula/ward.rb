class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.792.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/91e5d38e-e372-4f4d-8684-86f83640f2d9"
      sha256 "ad2821ff0cb61dfd227f00662682bd1431e33e500f23575fb2a2c5301095086d"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/fdc8620a-b887-4083-b6fc-ce6ebfac9d61"
        sha256 "43fec2d49925e1bb970cd3b0c395572f8efb7ef09e0a2afa013d522edd707c5c"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/bd179743-e077-4359-8ab2-99bb0909ddc5"
      sha256 "b28db653cb998dc480ffe6a7a0e20b64197b70363d3cf4afb669208c83f65104"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/7673f44a-f438-4504-ba3d-903669290462"
        sha256 "eba68cd08c6d43763486349e1ff9505ab235682745cdff8a22aa25a26d621636"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/fdc8620a-b887-4083-b6fc-ce6ebfac9d61"
      sha256 "43fec2d49925e1bb970cd3b0c395572f8efb7ef09e0a2afa013d522edd707c5c"
    else
      url "https://forgejo.coilysiren.me/attachments/7673f44a-f438-4504-ba3d-903669290462"
      sha256 "eba68cd08c6d43763486349e1ff9505ab235682745cdff8a22aa25a26d621636"
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
