class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.659.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.659.0/ward-darwin-arm64"
      sha256 "e3e854e4c5b9e852f474494ce580ffddeebd25fbdcf4a7b1b191dcbfbe54174e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.659.0/ward-darwin-amd64"
      sha256 "4e230b186b5fe10c336f6eb5fd5c5cd3478efa94b465cf26b65c8682f03dfdcb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.659.0/ward-linux-arm64"
      sha256 "af3ce5f2155a16fa35505a49275ca25ceb40275d6cf6fc318e8c1ffe0485cc5a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.659.0/ward-linux-amd64"
      sha256 "bd092ffab13d87cb7d0fc45ac2158d5f3b8e62c13f45e8ce9ad6fc5ae3bd35d2"
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
