class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.804.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/355a2975-450c-41b0-a4b1-f1170058afb3"
      sha256 "25089a646f7c21977cc0820ce7069556b05ea6a5b139109838775872bb09cdeb"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/9c64a0a6-335b-4649-8c09-31c16d6bc686"
        sha256 "eb36b94594f7aba9949806106e70aee4bf2d9c850df0f07b6a4f23f5880327fd"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/7e00233e-63e0-47ef-8cfd-5cb6f1f86029"
      sha256 "1f27b227ccc9c320cb1be42860a4c95bcf9ed665905b847be1a055809d3660dd"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/933692f8-e1da-4e10-b834-c3c63e67fe36"
        sha256 "43d4803d2181bd80d058941abd2928b00d6cdfc89e8b3765b8234590b2e52a5a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/9c64a0a6-335b-4649-8c09-31c16d6bc686"
      sha256 "eb36b94594f7aba9949806106e70aee4bf2d9c850df0f07b6a4f23f5880327fd"
    else
      url "https://forgejo.coilysiren.me/attachments/933692f8-e1da-4e10-b834-c3c63e67fe36"
      sha256 "43d4803d2181bd80d058941abd2928b00d6cdfc89e8b3765b8234590b2e52a5a"
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
