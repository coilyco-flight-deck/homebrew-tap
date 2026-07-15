class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.694.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.694.0/ward-darwin-arm64"
      sha256 "176bdb7c6495a08f72f69df9415243dbfc1493b5c53d5412eeb86f2677293cc6"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.694.0/ward-darwin-amd64"
      sha256 "3027ad4c7c30e986989dedc513d8eb9f98356417072b22f1c3b4a19cbb6f9b95"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.694.0/ward-linux-arm64"
      sha256 "f41393feda0d3bdf94a33a1d5d033b0c872959af56db43f5a323bcc5d7deb166"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.694.0/ward-linux-amd64"
      sha256 "ca7248601f29a889a11327976fa434572413bf89b0d0224d8e4b365d203d4300"
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
