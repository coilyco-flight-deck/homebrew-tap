class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.638.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.638.0/ward-darwin-arm64"
      sha256 "0f2d80c48d63541f1974f56dd3e622aa05776b4ae75d17d0e56657609482fac1"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.638.0/ward-darwin-amd64"
      sha256 "e5862cf3d12227b2b94c2581536f05c26edfec9e3bc300348f3a8784f220a53c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.638.0/ward-linux-arm64"
      sha256 "9f9d673b5e1561d635b29c19160f7e85ccab9ba8d52b6740f3fd49907191558f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.638.0/ward-linux-amd64"
      sha256 "c5997fc64826bb53a9902d29a8627c2a0710ab2ec48409bbb083da39fac5db22"
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
