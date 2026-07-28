class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.847.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.847.0/ward-darwin-arm64"
      sha256 "28f40b6b36adb4477c54c1fd500c4f806ac6b6a4c7b27187185f38cd08b2781f"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.847.0/ward-linux-arm64"
        sha256 "ea5aa96ca980861aac7e2d43dc67b68b8e0578a2119f716c47b635fccce4a408"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.847.0/ward-darwin-amd64"
      sha256 "6db324c8f55ab9379467332b6ce44185db497c79d2d9f5ebf4b0c33565664b65"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.847.0/ward-linux-amd64"
        sha256 "f7998f3623b267d4b7eca1bc291313d8f370fb7b982593f9cc59e3729212638e"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.847.0/ward-linux-arm64"
      sha256 "ea5aa96ca980861aac7e2d43dc67b68b8e0578a2119f716c47b635fccce4a408"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.847.0/ward-linux-amd64"
      sha256 "f7998f3623b267d4b7eca1bc291313d8f370fb7b982593f9cc59e3729212638e"
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
