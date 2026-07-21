class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.784.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.784.0/ward-darwin-arm64"
      sha256 "f7970b0faabd50d5c0aaf1849954a4a03f995dfbff317f456a7b996e214481cc"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.784.0/ward-linux-arm64"
        sha256 "0f45ba7c386baa1b6b4197d35a6d0319fd6d2d9be4c37ab30a0090e64b1fbbbb"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.784.0/ward-darwin-amd64"
      sha256 "52a601f5e16f747a5032bbfbb1efaf902c5aae32987c9fa494e0ba3226257a25"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.784.0/ward-linux-amd64"
        sha256 "6783880c426a1eab59df1abdd6c91d88d216c87f9e25031a0201eb635933da84"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.784.0/ward-linux-arm64"
      sha256 "0f45ba7c386baa1b6b4197d35a6d0319fd6d2d9be4c37ab30a0090e64b1fbbbb"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.784.0/ward-linux-amd64"
      sha256 "6783880c426a1eab59df1abdd6c91d88d216c87f9e25031a0201eb635933da84"
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
