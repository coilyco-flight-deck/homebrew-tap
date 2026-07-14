class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.682.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.682.0/ward-darwin-arm64"
      sha256 "3321decea1ea814bfd04603a9d72e198b770dd3309b2f9dbd17a3031d039f191"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.682.0/ward-darwin-amd64"
      sha256 "0ad71231e21c01db8d059cd4ed089900af5d9a88b83868fd63f526cac220bdac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.682.0/ward-linux-arm64"
      sha256 "88c81f260654811ef96fe66ea02c054259c405bbad24ad863aa86f4d66e2eae6"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.682.0/ward-linux-amd64"
      sha256 "4a3d831ec9e4d5465cf637d176b2af90f769b29cb3fe63f78f3652672f2962fc"
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
