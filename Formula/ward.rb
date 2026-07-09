class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.510.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.510.0/ward-darwin-arm64"
      sha256 "ef984d2b12703cb26aa9dd78f85b2df562b68876ac32b4bef52f4bff89b68ba3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.510.0/ward-darwin-amd64"
      sha256 "706d0915ab47b2cb28424bfa39afeda226dd110d5860947b6b90ab003c12e1ca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.510.0/ward-linux-arm64"
      sha256 "94cc4d1ae0f826563a2e7b11f6c54c930fbb67961b30a8e46651d4004781f270"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.510.0/ward-linux-amd64"
      sha256 "031a16fc51c5a0bbf85eb4f85493ac4e7ab1464901aed0de8d3601dd0706ca0f"
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
