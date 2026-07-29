class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.861.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.861.0/ward-darwin-arm64"
      sha256 "7b05f13dfb29fa4b245b0cd385335778743c0ec2b8b926be342084ef4cfe5658"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.861.0/ward-linux-arm64"
        sha256 "1069f06782c8babdeafe9d6f1792c3590dfd10a8ce04a9d2713910f3f0c5310a"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.861.0/ward-darwin-amd64"
      sha256 "832c75b6511755ee7d4f7cc434ebd833919d3e163351585ab5bf060d9274047a"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.861.0/ward-linux-amd64"
        sha256 "c4a3f3f1d65370b8e68767bc6fbb004824a454da38f3a84674fb9c363c2d3571"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.861.0/ward-linux-arm64"
      sha256 "1069f06782c8babdeafe9d6f1792c3590dfd10a8ce04a9d2713910f3f0c5310a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.861.0/ward-linux-amd64"
      sha256 "c4a3f3f1d65370b8e68767bc6fbb004824a454da38f3a84674fb9c363c2d3571"
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
