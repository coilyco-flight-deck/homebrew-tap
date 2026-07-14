class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.668.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.668.0/ward-darwin-arm64"
      sha256 "424d3b114910170a80c229c7c755963f502606c871534dd907f0c65a70df8a6e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.668.0/ward-darwin-amd64"
      sha256 "84f2939a056346633686c667c99fcd4719f9c5b932b6bab8d5b5c9714b3c2dfe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.668.0/ward-linux-arm64"
      sha256 "bc6a0fec43bcd76130ba9db4bdaa314aa80bc471dcf22d6f6a0bf2fa0adaa359"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.668.0/ward-linux-amd64"
      sha256 "ab5b0cfecd0e1bb315c2b2483fba6514702e576e53ceeb8bb81b6c00b86ebf60"
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
