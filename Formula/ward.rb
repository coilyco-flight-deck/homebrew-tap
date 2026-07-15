class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.696.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.696.0/ward-darwin-arm64"
      sha256 "ffbc261c64fb213fa27e973ddf47eb4a0b08ce1b1260974644802b9335bfd0e6"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.696.0/ward-darwin-amd64"
      sha256 "cefce6b9fd877821e29f9106ea957ed7748ddac866081c71536b7260282555a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.696.0/ward-linux-arm64"
      sha256 "625de17cc2a69ffd60ae7052b5144b413cc95ed210dba9adc34a2a5111ea364e"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.696.0/ward-linux-amd64"
      sha256 "f37e77c6c2e9a17a4a7a958779e3164df3f7558b6826880d39cb7073a9d9845f"
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
