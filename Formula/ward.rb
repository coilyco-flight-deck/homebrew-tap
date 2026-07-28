class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.846.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.846.0/ward-darwin-arm64"
      sha256 "06dcf9ee468b89424a49fcbef3683de08cb3ae45b5f61f816e000124dcacc02e"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.846.0/ward-linux-arm64"
        sha256 "9c1b0b0ba8acf70d8a1416aa8e2e04d6588b2780592907132bea0e0587e96359"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.846.0/ward-darwin-amd64"
      sha256 "b54207bcb1342563054abf9ddd3de9a8d292ef63b8797628ad853cd658a879f4"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.846.0/ward-linux-amd64"
        sha256 "d4f1cabf29dfc2c8d43c9f01807f7d3bdc288261bbfa376b07b2467d51c835e8"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.846.0/ward-linux-arm64"
      sha256 "9c1b0b0ba8acf70d8a1416aa8e2e04d6588b2780592907132bea0e0587e96359"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.846.0/ward-linux-amd64"
      sha256 "d4f1cabf29dfc2c8d43c9f01807f7d3bdc288261bbfa376b07b2467d51c835e8"
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
