class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.540.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.540.0/ward-darwin-arm64"
      sha256 "6db584e6f07f40567b6e3a5be47d4ae27204f83e0cdc654aa4bc5bdcca8ba1cf"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.540.0/ward-darwin-amd64"
      sha256 "8cfa48485751cf3170d0193f8aac0d6e61a273294b0077a4bda66a7b75a72517"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.540.0/ward-linux-arm64"
      sha256 "c90fa98a6aaecdc8144e1ebfc1ab35d76eb36fe718d3db8a0fe251608fbbf904"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.540.0/ward-linux-amd64"
      sha256 "2169fb424a077e9402695fb87adbb1f6c76eca43280f498c07245256ab843881"
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
