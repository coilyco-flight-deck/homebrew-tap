class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.627.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.627.0/ward-darwin-arm64"
      sha256 "70cae9c6eac893a1bd10ab3fa9f79d666d1cf0dc4053d18a11f5fb0979886143"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.627.0/ward-darwin-amd64"
      sha256 "7d5fedfc4e29446e06a3b10697000dccddfba403e60a5a2f81280bef146bf609"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.627.0/ward-linux-arm64"
      sha256 "ad2ec1958fafd625a7a5be83781038c9d5d33d509df03dd9b13edb93847cd4ee"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.627.0/ward-linux-amd64"
      sha256 "c6cc4426822edfc4bfb52559ac4cc344854425ef28c03532dcb686de23e2fc6e"
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
