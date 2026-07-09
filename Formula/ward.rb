class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.476.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.476.0/ward-darwin-arm64"
      sha256 "c9b8b7bdc669772f1e30ef5cbb6a4acc95efc3133256ceab9d78eb2b5b4e16a4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.476.0/ward-darwin-amd64"
      sha256 "ade596187968a493d758efe66fb439c643b0d5986debfdf4ccd35e1df427d3e6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.476.0/ward-linux-arm64"
      sha256 "988af9165285581b2fba9cc3a5fdc8888eea4466ee333c62537fe5c2c1c4e0d9"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.476.0/ward-linux-amd64"
      sha256 "5616a1cd75c69f172ecd2ae6cdf5b86f61b51af4987a017049c5e65637765872"
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
