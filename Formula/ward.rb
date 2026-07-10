class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.586.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.586.0/ward-darwin-arm64"
      sha256 "0c203ce08e5436b0c24a7fafc4140da1c3b6d3587e3b36eac45411d0cb481bbd"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.586.0/ward-darwin-amd64"
      sha256 "fb3c5bfa5a15b241b4c41c283be3814a189c51debf7afc2ccc88f47bb1ab85c1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.586.0/ward-linux-arm64"
      sha256 "19676a660d54661b85be64a34203931d060e9d1eb33025898b5d54008d322a79"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.586.0/ward-linux-amd64"
      sha256 "4a41047df412664e83e7443bd0d4c99b86706cdb31383f5a3bba7c4403b73fec"
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
