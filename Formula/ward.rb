class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.687.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.687.0/ward-darwin-arm64"
      sha256 "082ca1f27d5fd5df66e6c32fd4c0fa3641b907fd4c5f9ea4bf80750a0a55672d"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.687.0/ward-darwin-amd64"
      sha256 "addf20084cefa3f25246a47fc734a5f5bd18900ac5b595f119b3e91f17346bd9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.687.0/ward-linux-arm64"
      sha256 "a0945db4353fef7594d26e5a4d9bec4a8478312689ec48fecce435d368086562"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.687.0/ward-linux-amd64"
      sha256 "23bf121afef111866a2333c3a30e23b6fabf5fb0011043589835f8e48377bff0"
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
