class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.811.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/0c8f2727-e971-4fdc-af4e-0023bb1fbba3"
      sha256 "a2340dfdff7d8e30dbdd2b8d44ebb66b23fb353b4ab426bb920794bcbdc933dd"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/2bc6ddcf-5a04-45a9-9f24-74cea852018c"
        sha256 "c91da77e986eb7189f3be3eafa8e3f6280a7c0e6bd719cf5550dc940eba7453e"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/7fc4b01e-abca-4b8b-9822-5f79a565f092"
      sha256 "3389f70634e00fdc8dfc0955554e328b6ae7b0927f5da425e962ee210766dc65"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/3dc7cf71-2e7f-4b35-9fc4-cde6df278eb8"
        sha256 "9bcbd176954ab7358d476cacc88dc5402ad61101fc6530743e62371dfb22bbc6"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/2bc6ddcf-5a04-45a9-9f24-74cea852018c"
      sha256 "c91da77e986eb7189f3be3eafa8e3f6280a7c0e6bd719cf5550dc940eba7453e"
    else
      url "https://forgejo.coilysiren.me/attachments/3dc7cf71-2e7f-4b35-9fc4-cde6df278eb8"
      sha256 "9bcbd176954ab7358d476cacc88dc5402ad61101fc6530743e62371dfb22bbc6"
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
