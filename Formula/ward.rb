class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.517.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.517.0/ward-darwin-arm64"
      sha256 "8efebaa219846392bf535b71049676eaef1779d57f8d0299aba0d88be9ad3d82"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.517.0/ward-darwin-amd64"
      sha256 "9fa6ddcd653b45ec83d4b2659e593b55be02ac416533113afefd3ab2dad55167"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.517.0/ward-linux-arm64"
      sha256 "9684792b9bd56c50c60a70ee60dd47b68c9af43d116c22e40acaba113d8b2448"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.517.0/ward-linux-amd64"
      sha256 "8bef5b9ee92b845ed30b44a4c13b01bf0c848cf37f4d19f0f3b158b73efc1288"
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
