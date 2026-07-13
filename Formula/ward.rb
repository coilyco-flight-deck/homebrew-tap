class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.656.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.656.0/ward-darwin-arm64"
      sha256 "f5dd7720c17cee92967b5979eea80872136298d1081c51debf9f3b24ca2fddea"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.656.0/ward-darwin-amd64"
      sha256 "4b4b8d6b68f1ad792814d2dd46cabae2c79ba560085102a239fae3c1e87acd1e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.656.0/ward-linux-arm64"
      sha256 "4110a259c441516b609a019c2b53c179361e46f6c7226ecab2ee2a51003171e6"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.656.0/ward-linux-amd64"
      sha256 "a3a5eee0042c251a2aeddc44a226acb07a6ead24f5c44f700584f37b528f9be5"
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
