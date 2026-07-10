class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.608.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.608.0/ward-darwin-arm64"
      sha256 "5bab922c6b72b612e1b3b79d48ac9f57328d6fa39f219e62f8279f05fd6338f9"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.608.0/ward-darwin-amd64"
      sha256 "fa6c74d69bc5cfdf2d3aae47585cd3ee3d6c7cc1e30121fac88f01b66a65b7b3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.608.0/ward-linux-arm64"
      sha256 "8f74e129a6130f61fea1dbeb779bbd0a344390598861b0b77c6d296a63d8db52"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.608.0/ward-linux-amd64"
      sha256 "0dd93d3e1450e8af8708acb44f41d1998602af1e8d5ca79e42d98f83a0661414"
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
