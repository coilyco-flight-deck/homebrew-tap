class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.823.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/e6985cea-ff20-401d-9185-07bed91c4846"
      sha256 "9606aa479372fa6c886d8f4ec86b991e34aa39dd0b196a43e718d8709c33240c"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/3e32eb81-c98a-4bf6-9912-a2fe4da6e45c"
        sha256 "111a4489b44495b89bae13c18ad1074c299b1d81b65cbf496453103809f4d7f3"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/4f32aaa6-e3f4-4a60-9d2e-1d8f460c8a61"
      sha256 "a16283fb63d3fa00f2447df2d77a199bac0e74363fcf1c839da81041b421c6ce"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/2579419b-f891-40fe-998d-55d49cbe26ee"
        sha256 "e9a38b46ae7cf5c093ae5d901200712cbe791e324b7d6258f89876fe1de36201"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/3e32eb81-c98a-4bf6-9912-a2fe4da6e45c"
      sha256 "111a4489b44495b89bae13c18ad1074c299b1d81b65cbf496453103809f4d7f3"
    else
      url "https://forgejo.coilysiren.me/attachments/2579419b-f891-40fe-998d-55d49cbe26ee"
      sha256 "e9a38b46ae7cf5c093ae5d901200712cbe791e324b7d6258f89876fe1de36201"
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
