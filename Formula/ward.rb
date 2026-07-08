class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.464.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.464.0/ward-darwin-arm64"
      sha256 "9c8fdc207ffcc909530a407a68d258f93221afff7fa89b6e6d93bfd7bd7baf25"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.464.0/ward-darwin-amd64"
      sha256 "f1ede89012bf8ab6c3536c1ab998f4c42b5f67ac1c2e1a0c2c89f9c6d4e89647"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.464.0/ward-linux-arm64"
      sha256 "c05d7c206319ee204660d93f78c4d98fd32bd3481a34efba8d8857c52d3a61cc"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.464.0/ward-linux-amd64"
      sha256 "39d6660966d0187544035635bef18402478f3dc5f6ab077bac1226eb0581c8a3"
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
