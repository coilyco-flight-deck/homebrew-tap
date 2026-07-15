class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.756.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.756.0/ward-darwin-arm64"
      sha256 "c8ed5120a07d7c42d17463b04aa96d52909d46cad7aa4724262c8a0e4c270634"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.756.0/ward-darwin-amd64"
      sha256 "81d003fd530b979a4a79e4c0c55e1e7835fb9edff495e667975abcea156cbb47"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.756.0/ward-linux-arm64"
      sha256 "584ce0368e4262271b99f9e13fd3e1ce737e4b076eaa8150a7364dee90c540e8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.756.0/ward-linux-amd64"
      sha256 "14cf1f6ea7c675c7de2145fd267e80e1e2f82fce9e4ad582a72cbb2b7ce86ea4"
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
