class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.748.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.748.0/ward-darwin-arm64"
      sha256 "a30fb805904263e2944c1944eed8fe6ccead52ec01373242b5a7672ad6ce5bd8"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.748.0/ward-darwin-amd64"
      sha256 "7e14b33e955105d36ba6e8831173f20202043defbe6d575070c5cedcee8035fd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.748.0/ward-linux-arm64"
      sha256 "3500ddfb037e8a007ee9b056c48205cfe4f52617adac08e49c125a818a92830c"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.748.0/ward-linux-amd64"
      sha256 "4ecd26a938b70ae6f141824b7416e3759ed83e980a5e22902310fa1323a4c6f6"
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
