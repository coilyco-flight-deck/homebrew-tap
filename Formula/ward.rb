class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.819.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/f54e5718-3549-4db3-9b0b-5556df1b3211"
      sha256 "6133325d957165d8ec0f56b149de0b350e0df9c4e1d98f6fbaf1749ef7375098"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/0df70e19-a2d3-4988-b2b3-493367a51ce9"
        sha256 "b62e9b7bc5e4bedbc0f16361c6075e9985063f7ee636ba83d5199485668bbe33"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/d81f6105-ee0d-4a45-bb0a-fdf4b230a886"
      sha256 "8304a103b79bc0bddee80c8f6d20198decac62c5d3a6c9f3f3c03b1f3b8eff1d"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/2838453e-3080-4d4f-af95-469228fa05d2"
        sha256 "7fd5ec2521137a04665f796f5d59997956b648764ba17783b7a5d8c0be1f292a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/0df70e19-a2d3-4988-b2b3-493367a51ce9"
      sha256 "b62e9b7bc5e4bedbc0f16361c6075e9985063f7ee636ba83d5199485668bbe33"
    else
      url "https://forgejo.coilysiren.me/attachments/2838453e-3080-4d4f-af95-469228fa05d2"
      sha256 "7fd5ec2521137a04665f796f5d59997956b648764ba17783b7a5d8c0be1f292a"
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
