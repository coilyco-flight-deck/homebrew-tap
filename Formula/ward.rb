class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.647.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.647.0/ward-darwin-arm64"
      sha256 "27f70ba4e33f66627a4dfad5c711e5dc80af48ea85c7dbdf0d87c4b9dc23a3ec"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.647.0/ward-darwin-amd64"
      sha256 "c18c067e319ee950db2bdac05d030936545dec6355efd20c79378b5bee020ebe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.647.0/ward-linux-arm64"
      sha256 "aa8b98f37796987f8de92b76dbb5efc8ce319ad436cd6ffeed7995a93c5a50b3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.647.0/ward-linux-amd64"
      sha256 "c25b4f3f90f6108a11c685f833bcb11134c0567cb503c5b04ae4591628f01ef8"
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
