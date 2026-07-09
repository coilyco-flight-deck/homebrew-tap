class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.478.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.478.0/ward-darwin-arm64"
      sha256 "64a6f7fe50413c09630fad601c1ddd0bdafd4741eaf9f2f79fc2c0c4cc553d8a"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.478.0/ward-darwin-amd64"
      sha256 "ad293882c01acf756b7f9f2cb02c86e87351aaeb7b8ad2341aa54a79d930cec4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.478.0/ward-linux-arm64"
      sha256 "74e521f64cc1a515cf190f6b247d669395c48d154a3f0c67457084232dcda495"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.478.0/ward-linux-amd64"
      sha256 "236093e58646d375ac06e0fdf79800c0d896046acd785716e17956ccfa68559c"
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
