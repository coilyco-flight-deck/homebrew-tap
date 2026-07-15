class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.726.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.726.0/ward-darwin-arm64"
      sha256 "09dff96561513724382c3218db802bb521123340c9e1476016c678a914a11f26"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.726.0/ward-darwin-amd64"
      sha256 "9f4cc67f915f58d50ddd41db05c87bff6628cb0f7d6fbbc9f043e70e3cf0b3bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.726.0/ward-linux-arm64"
      sha256 "7f93af40b96d8b56c07db8c9ad3263ac5652581c4bd1809efbb6223c04595a28"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.726.0/ward-linux-amd64"
      sha256 "677ce6791c2b5ca11bbf85f35694c2bd729d0a1afb26f7ebd7927c8df1156124"
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
