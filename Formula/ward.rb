class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.636.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.636.0/ward-darwin-arm64"
      sha256 "c23a1fe3bced8d6a82465bbfd9b0d2acd40b8c70ab038abf3737bc56fb1b2132"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.636.0/ward-darwin-amd64"
      sha256 "127845a975fd0e6b9ed8a01ef6c82fb60b00b48c6dbfbdfd68a5509164417466"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.636.0/ward-linux-arm64"
      sha256 "75de9cd5ee8e3a6a64939b7b14aa2520761cc2fb24f672710fa7a05a71e61827"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.636.0/ward-linux-amd64"
      sha256 "d655dc513eeaadde7392af06bbf328bb6e7d979995e1df608015bff492f14f19"
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
