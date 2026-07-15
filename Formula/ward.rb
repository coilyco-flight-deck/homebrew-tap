class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.714.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.714.0/ward-darwin-arm64"
      sha256 "4a74cddc91f2dd607068482149321cfc79147f46c3fe4120359b774b5735e64b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.714.0/ward-darwin-amd64"
      sha256 "0d40288789c3605c80cb939842c132bf8baa61e7004615952e847f729796cf27"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.714.0/ward-linux-arm64"
      sha256 "ccdc3483da1d53a2cc81233ca561ea9564e8cba4ea2b5e7a99327b785156474f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.714.0/ward-linux-amd64"
      sha256 "27cdd69e85b1ae8ae8b0747c1bbb6bd6d7a2fde80a09747d18454cfa999efc20"
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
