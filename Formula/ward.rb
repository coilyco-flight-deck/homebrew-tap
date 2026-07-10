class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.548.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.548.0/ward-darwin-arm64"
      sha256 "7009efa15b8649c764c2f291b7e7b1ee7bc3f048ebced3824eee6934331d0bd0"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.548.0/ward-darwin-amd64"
      sha256 "ce684afb2798b1e1ad763314d54ca9bcfe6f6fceb09f07d3956fbd0aca486f6c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.548.0/ward-linux-arm64"
      sha256 "e5b4893775a541165890dcf729905eaabed3424022870f831e3eaa0855d667df"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.548.0/ward-linux-amd64"
      sha256 "d36dfed9495bd2f872a5af6f12ca3ca917eaadb6d2f74bb4b4c88052b0bf33b0"
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
