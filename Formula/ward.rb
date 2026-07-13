class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.646.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.646.0/ward-darwin-arm64"
      sha256 "5bea1444a897ff81af3774054c99d005f0b18347d043ea3749c0c8ddf33a9e24"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.646.0/ward-darwin-amd64"
      sha256 "ea5efdfc504a35e6f3a69aa1dbcaa9d3dd9222d151d44c126d93c945d7ff397e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.646.0/ward-linux-arm64"
      sha256 "1fd86fa9c4aaf1823f9585fca9a2e9d3336895133cd0315eb7ab685743d635df"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.646.0/ward-linux-amd64"
      sha256 "9dce1fbb472ff8d5f0d3b01910d855008984b4ecfd2b6c14996becca56884e47"
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
