class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.569.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.569.0/ward-darwin-arm64"
      sha256 "80dd45e76d790e841d01d61bb66bee6f4be398efcd8c7d559e5b8c89023be828"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.569.0/ward-darwin-amd64"
      sha256 "6139cad2eec5274deb46971190addcb3098795cc6e80ebe08a0b50cda1158ddb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.569.0/ward-linux-arm64"
      sha256 "821255da62a66d74d45040e9b90afb862efd68845d521c28fd80f6356e2e3e73"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.569.0/ward-linux-amd64"
      sha256 "017cc6f5e13a87697ba9c95377a468dd7d50b5291b65b632f8e4e07e3c6d0af5"
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
