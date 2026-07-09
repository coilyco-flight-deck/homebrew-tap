class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.534.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.534.0/ward-darwin-arm64"
      sha256 "69fb94163712f2d6782d5e4aba4b1180018132ab8b5163d26af0402e457a09ad"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.534.0/ward-darwin-amd64"
      sha256 "149696a2ad2543ba422f7792b3aa735e1dfe5ffe3b2f11ffab46468da47b79fd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.534.0/ward-linux-arm64"
      sha256 "ea48d11f4c3b07f976d0075119d0d893d2e504cf1a84a83e7a5041f5459aa3cd"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.534.0/ward-linux-amd64"
      sha256 "5739441c65f50fffbf48deafaeb3dca2c13960d019f973099e31d06ce9bfd495"
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
