class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.680.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.680.0/ward-darwin-arm64"
      sha256 "f6e5d2f74ea2abf9d558aafa6398bc4f9df45f1a5d0b7a54b052273928ef0657"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.680.0/ward-darwin-amd64"
      sha256 "bb71d57ccea13d4ca6f6e0fa8dc93bb4f4741ac9d22e51be7ecb5a447de97e46"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.680.0/ward-linux-arm64"
      sha256 "c17f38ebbd94bdda8dbb0f893a7b08bff36efbed3d42fa021059249636055ce3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.680.0/ward-linux-amd64"
      sha256 "66b2d527bf6b2b5d9b5fd59b0f987dfb1ab0cf5f27b7d1013c3a4b3ee3e248df"
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
