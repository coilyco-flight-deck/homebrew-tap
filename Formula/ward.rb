class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.681.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.681.0/ward-darwin-arm64"
      sha256 "9e5d9811a0c0259907b9ae769deb8d0949dee95761de145ef4b24ac66b9982c1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.681.0/ward-darwin-amd64"
      sha256 "67232fa37f61fc7b0b1c6e9d4da63e9975f6cb134b5f687d92e445656fabd594"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.681.0/ward-linux-arm64"
      sha256 "784ef8f302b0d8c3518344e84d661a7c657518fecaf4c58319c55f564437a984"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.681.0/ward-linux-amd64"
      sha256 "7a0a250a393113bd56736f3bb94ea6d134893503b9761eeb912c4e375e47b657"
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
