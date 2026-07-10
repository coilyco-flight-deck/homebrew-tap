class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.552.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.552.0/ward-darwin-arm64"
      sha256 "0beb9e196f91b84ebcb72a20aac47623030df5d47aac92e020374b37c3957345"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.552.0/ward-darwin-amd64"
      sha256 "d97a1ddad5c6cc7ff7a3db5fa7b6b42ab922abbf565193407b8b5f74f42f9627"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.552.0/ward-linux-arm64"
      sha256 "d1c3e4ca70d17254e3049a4f8e9a96bb9251e6df3b7b35b342782c166b085410"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.552.0/ward-linux-amd64"
      sha256 "3718e4d6d2318a46adcee0b7bcba6af3abe9d61c2fccfba1313ef0c21310159e"
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
