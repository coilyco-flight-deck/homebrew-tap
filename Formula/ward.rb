class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.564.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.564.0/ward-darwin-arm64"
      sha256 "682ffd86c2ff04bf316b5aa99722107be89690f27f75631df12ddb17e8617663"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.564.0/ward-darwin-amd64"
      sha256 "460f3800e677d56775bdde9394c586c81e63a9a28c46678e697e0c927b44d7ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.564.0/ward-linux-arm64"
      sha256 "8d4f541d3157296eb4d4aeb6f1970e6227b085fe94a8eff9c02816db53ec9176"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.564.0/ward-linux-amd64"
      sha256 "177c0a23e1ceefbd71ca08a2fe27e66fbefe344b3f0fda6ea6bad09b5b2717d4"
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
