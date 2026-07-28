class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.842.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.842.0/ward-darwin-arm64"
      sha256 "1819a458d71518e2a6d31d7786b08e79004739e8e3e81b4616ac9da04862eb25"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.842.0/ward-linux-arm64"
        sha256 "9db1e54ee426bcbbb5c47c7df5dd23d02306f7cf8209b093990413b2b213d6ec"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.842.0/ward-darwin-amd64"
      sha256 "834d9aee7d3c8b5ce33e2d3617031d8d3ee5da71c7b035947c57fddc13f7b52c"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.842.0/ward-linux-amd64"
        sha256 "b0803cc2f843e529838c9e98d491c48deda424dcd54eb892b14a9b43a3e0fa5d"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.842.0/ward-linux-arm64"
      sha256 "9db1e54ee426bcbbb5c47c7df5dd23d02306f7cf8209b093990413b2b213d6ec"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.842.0/ward-linux-amd64"
      sha256 "b0803cc2f843e529838c9e98d491c48deda424dcd54eb892b14a9b43a3e0fa5d"
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
