class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.863.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.863.0/ward-darwin-arm64"
      sha256 "0b2969d6cf218553ba06f1e56d1b2745e9ac8c26d1fdb8de54bc99da6afe51bb"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.863.0/ward-linux-arm64"
        sha256 "c1a9023bf971c52daf7fd4b5455e2936839dab2fd23a7131caedc2edae04fef5"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.863.0/ward-darwin-amd64"
      sha256 "80e4defcf3f8521215de9c0dc096f953af1060f529ffd3466fa13a1f57c44a3e"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.863.0/ward-linux-amd64"
        sha256 "cff99b7bf6633e425fb08523bfde3be1af84a1127c372c9a0a0b807447ed850b"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.863.0/ward-linux-arm64"
      sha256 "c1a9023bf971c52daf7fd4b5455e2936839dab2fd23a7131caedc2edae04fef5"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.863.0/ward-linux-amd64"
      sha256 "cff99b7bf6633e425fb08523bfde3be1af84a1127c372c9a0a0b807447ed850b"
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
