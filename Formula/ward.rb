class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.565.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.565.0/ward-darwin-arm64"
      sha256 "c302315ec6841015fc1d63ca79b718a74650f8bac9f8bd2ddf9f625f7b8061b3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.565.0/ward-darwin-amd64"
      sha256 "afed4e3b6106d3db99fa35c752b208c035bc502c983021f1ee54b9710699d22f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.565.0/ward-linux-arm64"
      sha256 "f366a9c93294fc027193133dbadf5277584e02b7d7fafd737cdd6dc9d1e65411"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.565.0/ward-linux-amd64"
      sha256 "8ef5c04b4c775984f58d00829abb809a6d25f21572c5791c51457ca71677a3ed"
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

    bin.install_symlink "ward" => "warded"

  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
