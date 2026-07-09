class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.484.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.484.0/ward-darwin-arm64"
      sha256 "119bd71a9b90a453358727d021f9119dfff5155b5d525b7a01e5ca6624f754b2"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.484.0/ward-darwin-amd64"
      sha256 "292ad113ba75ca8357b8e5854e46732cc260f801599c238f3886d73d7c82ff42"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.484.0/ward-linux-arm64"
      sha256 "19142f1a26e54a727f4c6ba5817ad6029665cfaa039280f8e64cbf8f0bae5e0b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.484.0/ward-linux-amd64"
      sha256 "f667d00f2d39ed4dffcc4c6053c64b4c82b683ffd93607bc55dc78f11cd7d92f"
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
