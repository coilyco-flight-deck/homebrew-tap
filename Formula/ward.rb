class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.495.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.495.0/ward-darwin-arm64"
      sha256 "12e892c9eefc5e211a49defc522babec4d297c833f64e061b892e7c0dc6c25d0"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.495.0/ward-darwin-amd64"
      sha256 "28e5e88403d06ead6001e7d5edf67cafd7541786d0a47b239dbac3833bdf13fb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.495.0/ward-linux-arm64"
      sha256 "26b03d1846a8d837dbb1609c49bbf4153cb61c488ca318e27d1dbaf5eb1ce659"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.495.0/ward-linux-amd64"
      sha256 "37c512fc1219222b4908870d21d9e5e64747dba69557b6a08931608ffe23cd2e"
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
