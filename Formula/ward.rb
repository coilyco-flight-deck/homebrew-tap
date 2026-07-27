class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.818.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/7ee517f8-bfd6-4c1a-aa1b-d7e390c58016"
      sha256 "b42b9fcb3f1c87367af4c40d3e42ad4e3c5a423751599cf3ee4fbee374ae3d29"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/a0c1bd89-66e2-46c8-9204-031fb348e81c"
        sha256 "3a963caf296646899818efd48550d1f04d21e3dda616036d65d88ebc182e4334"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/ea26dc01-a491-4517-bb32-3833b356b38f"
      sha256 "714aa03c6a710f8d3f9d22ec332169659e9990debf9906da32ca2c2b8961e549"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/2e719f66-0d55-4fc5-ba45-9304067983dd"
        sha256 "77cdbb3c970a4b2b9f228686dfe194b337af8a7d7fc0f7a6ee0505faf8cc36b9"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/a0c1bd89-66e2-46c8-9204-031fb348e81c"
      sha256 "3a963caf296646899818efd48550d1f04d21e3dda616036d65d88ebc182e4334"
    else
      url "https://forgejo.coilysiren.me/attachments/2e719f66-0d55-4fc5-ba45-9304067983dd"
      sha256 "77cdbb3c970a4b2b9f228686dfe194b337af8a7d7fc0f7a6ee0505faf8cc36b9"
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
