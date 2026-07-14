class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.684.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.684.0/ward-darwin-arm64"
      sha256 "92a77e5d7e80781f8d1ff70c5680099b87e5b981dc96d516a2dcff86d5f253c8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.684.0/ward-darwin-amd64"
      sha256 "fb42e813b27930682dffe002b311df5ffbeb457b6a0b525b5761da8ac2fddaef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.684.0/ward-linux-arm64"
      sha256 "fcf0a547ec5b9883e7a5a2ecf3966facefb619097e8e6faadffe527792a198fe"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.684.0/ward-linux-amd64"
      sha256 "04950c278bf4c865d10573e721a4c30f1cb30a7bfe1f500ae9a6c3974afc49e3"
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
