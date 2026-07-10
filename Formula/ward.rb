class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.551.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.551.0/ward-darwin-arm64"
      sha256 "cdc7f0e13ff0713afd3d7d2902b635b46224245f04420d17bdd94e1f5421aeaf"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.551.0/ward-darwin-amd64"
      sha256 "0d5ac60fe13c1ece10881029c099c87a927bea6b378cfd35521d224ce13161af"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.551.0/ward-linux-arm64"
      sha256 "7e43eeca57fa44b08f951ba42d690656999a72bc1488c4c8dba58dc035875552"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.551.0/ward-linux-amd64"
      sha256 "0013a62194cf59e1c9233976cecf3c3b9368879e7bb8de2d4a00a6af57e7b8f0"
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
