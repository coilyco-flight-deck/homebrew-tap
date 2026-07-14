class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.662.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.662.0/ward-darwin-arm64"
      sha256 "6f460709a1821585a5ab1e7041940ca64608565615601f45699495791985e1a1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.662.0/ward-darwin-amd64"
      sha256 "ef0b784498ad922fb8f66d4b0f5a176db516a7deb64466d286c006dbda0c903e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.662.0/ward-linux-arm64"
      sha256 "c3ebdaa764004d6c0dda7abff04fde415a3df4d105a148eca0e449de2bb3fd6b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.662.0/ward-linux-amd64"
      sha256 "db50e07d9accb3ae93b72840d369a9000dd8b8d7518601b89e1ae52e8cc35466"
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
