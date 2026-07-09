class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.504.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.504.0/ward-darwin-arm64"
      sha256 "2a209a64eaa02835936b47bc4a3838c82c804e5148ae7301d786153b341c7019"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.504.0/ward-darwin-amd64"
      sha256 "fdbf4e3bbf129f40b82159ef03c52f2754ec39500ad4d57c196e80da3c4cd218"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.504.0/ward-linux-arm64"
      sha256 "78ee831349fe034c9e3849f894e6d39f8a9e765e44dba4f42f4e5d1e77cb38ce"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.504.0/ward-linux-amd64"
      sha256 "d8488041c4d7081af29d6d52f2b334bd0287adf1fbb651999580e99e5f458cfb"
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
