class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.620.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.620.0/ward-darwin-arm64"
      sha256 "cebec911efecb1fcee902d6f2a2ed397497e967e42ec596ba428a36d95a1b2b4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.620.0/ward-darwin-amd64"
      sha256 "ab45a49fc5125a05704454b727b7192e9cc827a2de5f2f1bd65b8a4b2c481b77"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.620.0/ward-linux-arm64"
      sha256 "56143638ab4c04864fba29f54ab65584cf185d4b63edae2993e24b00c3bbe35a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.620.0/ward-linux-amd64"
      sha256 "fec45aa2e7984174c8e0289a16d1a6eb7f2048e50fdec94eb5b356a399b65807"
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
