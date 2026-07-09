class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.529.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.529.0/ward-darwin-arm64"
      sha256 "18c9945294ce9e9ab50dc0424889b8caf2536d717a94dbb5290d0464e0a05f3b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.529.0/ward-darwin-amd64"
      sha256 "5a2a912bf48fa03fc04b49d5582530402c74789590e9d0642d0f154ddac4f806"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.529.0/ward-linux-arm64"
      sha256 "f7bbe7c52f9687d2825f284a282b44f5d49aa4a8716488d12fb8dd029a0a405f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.529.0/ward-linux-amd64"
      sha256 "dd44dffa0f65bfb62f9fde0010ec5eb296a93beb7a1eea278f53528a0333f6d7"
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
