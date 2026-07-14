class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.672.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.672.0/ward-darwin-arm64"
      sha256 "424d6255ea67132d586ca71725e0011acaa6e63231933f8b24bbf8044d191d62"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.672.0/ward-darwin-amd64"
      sha256 "363e3c303bb8550a7a237d9eb24f9ac10734d2911a489ac6606031719e21671d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.672.0/ward-linux-arm64"
      sha256 "ba7fb60610d86287aba5372b47fd47dbb5c29846fcf36cf30fbf2c32f7926df8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.672.0/ward-linux-amd64"
      sha256 "7c2c1c11928815d76bf3d5e9e698906b297ae84c92ef5071cecfdff75ed14847"
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
