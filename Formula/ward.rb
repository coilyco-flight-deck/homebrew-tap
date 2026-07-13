class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.645.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.645.0/ward-darwin-arm64"
      sha256 "e146c4380f42f3bc8e42ae78abef65d7d8a5956a66affb6fa7699ece3384c165"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.645.0/ward-darwin-amd64"
      sha256 "9c06a200b3c88882fb59d900cac0ff7969498f1da033021eebdb7c2f43e9b3ca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.645.0/ward-linux-arm64"
      sha256 "cf00051362cddf8d5a6dc742718d7026d7d9a3369752a9e2829bfc64badb92d1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.645.0/ward-linux-amd64"
      sha256 "c6c59a4a2ffb4f8a5a3b267fc10ba682814424e3452615bd17eab2e165996c43"
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
