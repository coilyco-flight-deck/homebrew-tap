class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.850.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.850.0/ward-darwin-arm64"
      sha256 "06b80091fbb0d5927dd9d8a863368952cc29f777c0d4247c0cc9fec435d8d40f"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.850.0/ward-linux-arm64"
        sha256 "43f887b996abda819106af03d783642058a6490c982df3c26a00562ff1f098b1"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.850.0/ward-darwin-amd64"
      sha256 "dec6d3efd11a4440b2b7a09ae9d27fb16c055bf3a7c8a339126e6616c1e87c02"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.850.0/ward-linux-amd64"
        sha256 "6cee7611723d08220417548ca1a19fef498f3adac83869ffe54cd1537c2dab56"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.850.0/ward-linux-arm64"
      sha256 "43f887b996abda819106af03d783642058a6490c982df3c26a00562ff1f098b1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.850.0/ward-linux-amd64"
      sha256 "6cee7611723d08220417548ca1a19fef498f3adac83869ffe54cd1537c2dab56"
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
